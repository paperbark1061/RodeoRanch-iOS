import SwiftUI

struct MyRunsView: View {
    @State private var selectedRun: Run?
    private var upcoming: [Run] { MockData.myRuns.filter { $0.status == .upcoming || $0.status == .onDeck } }
    private var completed: [Run] { MockData.myRuns.filter { $0.status == .completed } }

    var body: some View {
        NavigationStack {
            List {
                if !upcoming.isEmpty {
                    Section("Upcoming") {
                        ForEach(upcoming) { run in
                            RunRow(run: run)
                                .onTapGesture { selectedRun = run }
                        }
                    }
                }
                if !completed.isEmpty {
                    Section("Results") {
                        ForEach(completed) { run in
                            RunRow(run: run)
                                .onTapGesture { selectedRun = run }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("My Runs")
            .sheet(item: $selectedRun) { run in
                RunDetailView(run: run)
            }
        }
    }
}

struct RunRow: View {
    let run: Run
    var body: some View {
        HStack(spacing: 12) {
            DisciplineBadge(discipline: run.discipline, size: .small)
            VStack(alignment: .leading, spacing: 4) {
                Text(run.eventName).font(.rrTitle3)
                Text(run.horseName).font(.rrBodySm).foregroundColor(.secondary)
                if let team = run.teamMembers {
                    Text(team.joined(separator: ", ")).font(.rrCaption).foregroundColor(.secondary)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                if let result = run.result {
                    if let placing = result.placing {
                        PlacingBadge(placing: placing)
                    }
                    Text(run.discipline.scoringType == .judgePoints
                         ? String(format: "%.1f pts", result.judgeScore ?? 0)
                         : result.displayTime)
                        .font(.rrLabel)
                        .foregroundColor(.rrGold)
                } else if run.status == .upcoming, let pos = run.drawPosition {
                    Text("Run #\(pos)").font(.rrLabel).foregroundColor(.rrInfo)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct PlacingBadge: View {
    let placing: Int
    private var color: Color {
        switch placing {
        case 1: return Color(hex: "#d4a017")   // gold
        case 2: return Color(hex: "#aaaaaa")   // silver
        case 3: return Color(hex: "#c07830")   // bronze
        default: return .secondary
        }
    }
    var body: some View {
        Text("\(placing)\(placing.ordinalSuffix)")
            .font(.system(size: 11, weight: .bold))
            .foregroundColor(color)
    }
}

extension Int {
    var ordinalSuffix: String {
        switch self % 100 {
        case 11, 12, 13: return "th"
        default:
            switch self % 10 {
            case 1: return "st"
            case 2: return "nd"
            case 3: return "rd"
            default: return "th"
            }
        }
    }
}
