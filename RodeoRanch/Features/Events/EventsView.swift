import SwiftUI

struct EventsView: View {
    @State private var searchText = ""
    @State private var selectedDiscipline: Discipline? = nil
    @State private var selectedStatus: EventStatus? = nil
    @State private var selectedEvent: Event?

    var filtered: [Event] {
        MockData.events.filter { event in
            let matchSearch = searchText.isEmpty ||
                event.name.localizedCaseInsensitiveContains(searchText) ||
                event.venue.localizedCaseInsensitiveContains(searchText)
            let matchDisc   = selectedDiscipline == nil || event.discipline == selectedDiscipline
            let matchStatus = selectedStatus == nil || event.status == selectedStatus
            return matchSearch && matchDisc && matchStatus
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Filter chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(label: "All", isSelected: selectedDiscipline == nil) { selectedDiscipline = nil }
                        ForEach(Discipline.allCases, id: \.self) { disc in
                            FilterChip(label: disc.shortCode, isSelected: selectedDiscipline == disc) {
                                selectedDiscipline = selectedDiscipline == disc ? nil : disc
                            }
                        }
                        Divider().frame(height: 20)
                        FilterChip(label: "Live", isSelected: selectedStatus == .live, accentColor: .rrSuccess) {
                            selectedStatus = selectedStatus == .live ? nil : .live
                        }
                        FilterChip(label: "Open", isSelected: selectedStatus == .open) {
                            selectedStatus = selectedStatus == .open ? nil : .open
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color.white)

                Divider()

                List(filtered) { event in
                    Button { selectedEvent = event } label: {
                        EventRow(event: event)
                    }
                    .listRowBackground(Color.white)
                }
                .listStyle(.plain)
                .background(Color.rrBg2)
                .searchable(text: $searchText, prompt: "Search events")
            }
            .background(Color.rrBg2)
            .navigationTitle("Events")
            .sheet(item: $selectedEvent) { EventDetailView(event: $0) }
        }
    }
}

struct EventRow: View {
    let event: Event
    var body: some View {
        HStack(spacing: 12) {
            DisciplineBadge(discipline: event.discipline)
            VStack(alignment: .leading, spacing: 4) {
                Text(event.name).font(.rrTitle3).foregroundColor(.rrTextPrimary)
                Text(event.venue).font(.rrBodySm).foregroundColor(.rrTextSecondary)
                Text(event.startDate, style: .date).font(.rrCaption).foregroundColor(.rrTextSecondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                EventStatusBadge(status: event.status)
                Text(String(format: "$%.0f", event.entryFee))
                    .font(.rrLabel)
                    .foregroundColor(.rrGold)
            }
        }
        .padding(.vertical, 4)
    }
}

struct FilterChip: View {
    let label: String
    let isSelected: Bool
    var accentColor: Color = .rrNavy
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.rrCaption)
                .fontWeight(isSelected ? .bold : .regular)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? accentColor : Color(hex: "#f3f4f6"))
                .foregroundColor(isSelected ? .white : .rrTextPrimary)
                .clipShape(Capsule())
                .overlay(
                    Capsule().stroke(isSelected ? Color.clear : Color(hex: "#d1d5db"), lineWidth: 1)
                )
        }
    }
}
