import SwiftUI

struct JudgeModeView: View {
    @State private var selectedEvent: Event? = MockData.events.first { $0.status == .live }
    @State private var activeRun: Run?
    @State private var showScoreEntry = false

    private var queue: [Run] { MockData.myRuns }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Arena banner
                HStack {
                    Image(systemName: "stopwatch.fill").foregroundColor(.white)
                    Text("Judge mode").font(.rrTitle3).foregroundColor(.white)
                    Spacer()
                    if let event = selectedEvent {
                        DisciplineBadge(discipline: event.discipline)
                    }
                }
                .padding()
                .background(Color.rrNavy)

                // Event selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(MockData.events.filter { $0.status == .live }) { event in
                            FilterChip(
                                label: event.name,
                                isSelected: selectedEvent?.id == event.id
                            ) { selectedEvent = event }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color.white)

                Divider()

                List {
                    Section("Run queue") {
                        ForEach(queue) { run in
                            JudgeRunRow(run: run) {
                                activeRun = run
                                showScoreEntry = true
                            }
                            .listRowBackground(Color.white)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .background(Color.rrBg2)
            .navigationTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showScoreEntry) {
                if let run = activeRun, let event = selectedEvent {
                    ScoreEntryView(run: run, event: event)
                }
            }
        }
    }
}

struct JudgeRunRow: View {
    let run: Run
    let onScore: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    if let pos = run.drawPosition {
                        Text("#\(pos)")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.rrGold)
                    }
                    Text(run.riderName).font(.rrTitle3).foregroundColor(.rrTextPrimary)
                }
                Text(run.horseName).font(.rrBodySm).foregroundColor(.rrTextSecondary)
                if let team = run.teamMembers {
                    Text(team.joined(separator: " · ")).font(.rrCaption).foregroundColor(.rrTextSecondary)
                }
            }
            Spacer()
            Button(action: onScore) {
                Label("Score", systemImage: "plus.circle.fill")
                    .font(.rrLabel)
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Color.rrNavy)
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 6)
    }
}
