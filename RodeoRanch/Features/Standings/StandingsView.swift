import SwiftUI

struct StandingsView: View {
    @State private var selectedDivision = "Open"
    private let divisions = ["Open", "Non-Pro", "Youth", "Senior"]
    private let board = MockData.leaderboard

    var filteredEntries: [StandingsEntry] {
        board.entries.filter { $0.division == selectedDivision }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                RRCard(padding: 12) {
                    HStack {
                        DisciplineBadge(discipline: board.discipline)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(board.eventName).font(.rrTitle3).foregroundColor(.rrTextPrimary)
                            Text("Updated \(board.lastUpdated, style: .relative) ago")
                                .font(.rrCaption).foregroundColor(.rrTextSecondary)
                        }
                        Spacer()
                        EventStatusBadge(status: .live)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(divisions, id: \.self) { div in
                            FilterChip(label: div, isSelected: selectedDivision == div) {
                                selectedDivision = div
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }

                Divider()

                List(filteredEntries) { entry in
                    StandingsRow(entry: entry)
                        .listRowBackground(entry.isCurrentUser ? Color.rrNavy.opacity(0.06) : Color.white)
                }
                .listStyle(.plain)
            }
            .background(Color.rrBg2)
            .navigationTitle("Standings")
        }
    }
}

struct StandingsRow: View {
    let entry: StandingsEntry

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(placingColor.opacity(0.15))
                    .frame(width: 36, height: 36)
                Text("\(entry.placing)")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(placingColor)
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 6) {
                    Text(entry.riderName)
                        .font(.rrTitle3)
                        .foregroundColor(entry.isCurrentUser ? .rrNavy : .rrTextPrimary)
                    if entry.isCurrentUser {
                        Text("You")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.rrNavy)
                            .clipShape(Capsule())
                    }
                }
                Text(entry.horseName).font(.rrBodySm).foregroundColor(.rrTextSecondary)
                if let team = entry.teamName {
                    Text(team).font(.rrCaption).foregroundColor(.rrTextSecondary)
                }
            }

            Spacer()

            Text(entry.score)
                .font(.rrLabel)
                .foregroundColor(.rrGold)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 4)
    }

    private var placingColor: Color {
        switch entry.placing {
        case 1: return Color(hex: "#d4a017")
        case 2: return Color(hex: "#6b7280")
        case 3: return Color(hex: "#c07830")
        default: return .rrTextSecondary
        }
    }
}
