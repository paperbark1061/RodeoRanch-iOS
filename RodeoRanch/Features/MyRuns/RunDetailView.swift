import SwiftUI

struct RunDetailView: View {
    let run: Run
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        DisciplineBadge(discipline: run.discipline, size: .large)
                        Spacer()
                        RunStatusBadge(status: run.status)
                    }
                    .padding(.horizontal)

                    Text(run.eventName).font(.rrTitle).foregroundColor(.rrTextPrimary).padding(.horizontal)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        DetailCell(label: "Horse",    value: run.horseName)
                        DetailCell(label: "Division", value: run.division ?? "Open")
                        if let pos = run.drawPosition {
                            DetailCell(label: "Draw #", value: "#\(pos)")
                        }
                    }
                    .padding(.horizontal)

                    if let team = run.teamMembers, !team.isEmpty {
                        RRCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Label("Team", systemImage: "person.3.fill")
                                    .font(.rrLabel).foregroundColor(.rrTextPrimary)
                                ForEach(team, id: \.self) {
                                    Text($0).font(.rrBodySm).foregroundColor(.rrTextPrimary)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    if let result = run.result {
                        ResultCard(result: result, discipline: run.discipline).padding(.horizontal)
                    } else {
                        RRCard {
                            Label("No result yet", systemImage: "clock")
                                .foregroundColor(.rrTextSecondary)
                        }
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 40)
                }
                .padding(.top, 16)
            }
            .background(Color.rrBg2)
            .navigationTitle("Run detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }.foregroundColor(.rrNavy)
                }
            }
        }
    }
}

struct ResultCard: View {
    let result: RunResult
    let discipline: Discipline

    var body: some View {
        RRCard {
            VStack(alignment: .leading, spacing: 12) {
                Label("Result", systemImage: "flag.checkered")
                    .font(.rrTitle3).foregroundColor(.rrTextPrimary)

                if discipline.scoringType == .judgePoints, let score = result.judgeScore {
                    ResultStat(label: "Judge score", value: String(format: "%.1f", score))
                } else {
                    ResultStat(label: "Time", value: result.displayTime)
                }
                if let cattle = result.cattleCount {
                    ResultStat(label: "Cattle counted", value: "\(cattle) head")
                }
                if let placing = result.placing {
                    ResultStat(label: "Placing", value: "\(placing)\(placing.ordinalSuffix)")
                }
                if let prize = result.prizeAmount, prize > 0 {
                    ResultStat(label: "Prize", value: String(format: "$%.2f", prize))
                }
                if let pts = result.pointsEarned, pts > 0 {
                    ResultStat(label: "Season points", value: String(format: "%.1f pts", pts))
                }
                if !result.penalties.isEmpty {
                    Divider()
                    Text("Penalties").font(.rrLabel).foregroundColor(.rrTextPrimary)
                    ForEach(result.penalties) { pen in
                        HStack {
                            Text(pen.name).font(.rrBodySm).foregroundColor(.rrTextPrimary)
                            Spacer()
                            Text(pen.type == .seconds ? "+\(Int(pen.value))s" : pen.type.rawValue)
                                .font(.rrCaption).foregroundColor(.rrDanger)
                        }
                    }
                }
            }
        }
    }
}

struct ResultStat: View {
    let label: String
    let value: String
    var body: some View {
        HStack {
            Text(label).font(.rrBodySm).foregroundColor(.rrTextSecondary)
            Spacer()
            Text(value).font(.rrTitle3).foregroundColor(.rrGold)
        }
    }
}

struct DetailCell: View {
    let label: String
    let value: String
    var body: some View {
        RRCard(padding: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(label).font(.rrCaption).foregroundColor(.rrTextSecondary)
                Text(value).font(.rrTitle3).foregroundColor(.rrTextPrimary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct RunStatusBadge: View {
    let status: RunStatus
    var body: some View {
        Text(status.rawValue.replacingOccurrences(of: "_", with: " ").capitalized)
            .font(.rrCaption).fontWeight(.semibold)
            .padding(.horizontal, 8).padding(.vertical, 3)
            .background(statusColor.opacity(0.12))
            .foregroundColor(statusColor)
            .clipShape(Capsule())
    }
    private var statusColor: Color {
        switch status {
        case .completed:          return .rrSuccess
        case .upcoming:           return .rrInfo
        case .onDeck:             return .rrWarning
        case .inProgress:         return .rrGold
        case .scratched, .noTime: return .rrDanger
        }
    }
}
