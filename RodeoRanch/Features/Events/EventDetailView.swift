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

                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            DisciplineBadge(discipline: event.discipline, size: .large)
                            Spacer()
                            EventStatusBadge(status: event.status)
                        }
                        Text(event.name).font(.rrTitle)
                        Text(event.venue).font(.rrBody).foregroundColor(.secondary)
                    }
                    .padding(.horizontal)

                    Divider()

                    // Details grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        DetailCell(label: "Start", value: event.startDate.formatted(.dateTime.day().month().year()))
                        DetailCell(label: "End",   value: event.endDate.formatted(.dateTime.day().month().year()))
                        DetailCell(label: "Fee",   value: String(format: "$%.2f", event.entryFee))
                        DetailCell(label: "Region", value: event.region.displayName)
                        DetailCell(label: "Entries", value: "\(event.currentEntries) / \(event.maxEntries)")
                        DetailCell(label: "Draw",   value: event.drawReleased ? "Released" : "TBA")
                    }
                    .padding(.horizontal)

                    // Entry fill bar
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Entries").font(.rrLabel)
                            Spacer()
                            Text("\(event.currentEntries)/\(event.maxEntries)").font(.rrCaption).foregroundColor(.secondary)
                        }
                        ProgressView(value: event.entryPercentage)
                            .tint(event.entryPercentage > 0.85 ? .rrDanger : event.entryPercentage > 0.6 ? .rrWarning : .rrSuccess)
                    }
                    .padding(.horizontal)

                    if let desc = event.description {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("About").font(.rrLabel)
                            Text(desc).font(.rrBodySm).foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                    }

                    // My run card (if already entered)
                    if let run = myRun {
                        RRCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Label("My entry", systemImage: "checkmark.circle.fill")
                                    .font(.rrTitle3)
                                    .foregroundColor(.rrSuccess)
                                if let pos = run.drawPosition {
                                    Text("Draw position: #\(pos)").font(.rrBody)
                                } else {
                                    Text("Draw not yet released").font(.rrBodySm).foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.horizontal)
                    } else if !event.isFull && event.status == .open {
                        RRButton(title: "Enter this event", icon: "plus") {
                            showEntryForm = true
                        }
                        .padding(.horizontal)
                    } else if event.isFull {
                        Label("Event full", systemImage: "xmark.circle")
                            .foregroundColor(.rrDanger)
                            .padding(.horizontal)
                    }

                    Spacer(minLength: 40)
                }
                .padding(.top, 16)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .sheet(isPresented: $showEntryForm) {
                EventEntryFormView(event: event)
            }
        }
    }
}

struct DetailCell: View {
    let label: String
    let value: String
    var body: some View {
        RRCard(padding: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(label).font(.rrCaption).foregroundColor(.secondary)
                Text(value).font(.rrTitle3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
