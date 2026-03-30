import SwiftUI

struct EventDetailView: View {
    let event: Event
    @Environment(\.dismiss) var dismiss
    @State private var showEntryForm = false

    var myRun: Run? { MockData.myRuns.first { $0.eventId == event.id } }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            DisciplineBadge(discipline: event.discipline, size: .large)
                            Spacer()
                            EventStatusBadge(status: event.status)
                        }
                        Text(event.name).font(.rrTitle).foregroundColor(.rrTextPrimary)
                        Text(event.venue).font(.rrBody).foregroundColor(.rrTextSecondary)
                    }
                    .padding(.horizontal)

                    Divider()

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        DetailCell(label: "Start",   value: event.startDate.formatted(.dateTime.day().month().year()))
                        DetailCell(label: "End",     value: event.endDate.formatted(.dateTime.day().month().year()))
                        DetailCell(label: "Fee",     value: String(format: "$%.2f", event.entryFee))
                        DetailCell(label: "Region",  value: event.region.displayName)
                        DetailCell(label: "Entries", value: "\(event.currentEntries) / \(event.maxEntries)")
                        DetailCell(label: "Draw",    value: event.drawReleased ? "Released" : "TBA")
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Entries").font(.rrLabel).foregroundColor(.rrTextPrimary)
                            Spacer()
                            Text("\(event.currentEntries)/\(event.maxEntries)")
                                .font(.rrCaption).foregroundColor(.rrTextSecondary)
                        }
                        ProgressView(value: event.entryPercentage)
                            .tint(event.entryPercentage > 0.85 ? .rrDanger :
                                  event.entryPercentage > 0.60 ? .rrWarning : .rrSuccess)
                    }
                    .padding(.horizontal)

                    if let desc = event.description {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("About").font(.rrLabel).foregroundColor(.rrTextPrimary)
                            Text(desc).font(.rrBodySm).foregroundColor(.rrTextSecondary)
                        }
                        .padding(.horizontal)
                    }

                    if let run = myRun {
                        RRCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Label("My entry", systemImage: "checkmark.circle.fill")
                                    .font(.rrTitle3).foregroundColor(.rrSuccess)
                                if let pos = run.drawPosition {
                                    Text("Draw position: #\(pos)").font(.rrBody).foregroundColor(.rrTextPrimary)
                                } else {
                                    Text("Draw not yet released").font(.rrBodySm).foregroundColor(.rrTextSecondary)
                                }
                            }
                        }
                        .padding(.horizontal)
                    } else if !event.isFull && event.status == .open {
                        RRButton(title: "Enter this event", icon: "plus") { showEntryForm = true }
                            .padding(.horizontal)
                    } else if event.isFull {
                        Label("Event full", systemImage: "xmark.circle")
                            .foregroundColor(.rrDanger).padding(.horizontal)
                    }

                    Spacer(minLength: 40)
                }
                .padding(.top, 16)
            }
            .background(Color.rrBg2)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }.foregroundColor(.rrNavy)
                }
            }
            .sheet(isPresented: $showEntryForm) { EventEntryFormView(event: event) }
        }
    }
}
