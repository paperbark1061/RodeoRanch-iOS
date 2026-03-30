import SwiftUI

/// Discipline-aware score entry sheet shown to a judge.
struct ScoreEntryView: View {
    let run: Run
    let event: Event
    @Environment(\.dismiss) var dismiss

    @State private var timerState: TimerState = .idle
    @State private var elapsed: Double = 0
    @State private var timer: Timer?

    // Score fields
    @State private var judgeScore: Double = 70.0         // cutting
    @State private var cattleCount: Int = 0              // penning / sorting
    @State private var timeString: String = ""           // barrel / penning (manual override)
    @State private var appliedPenalties: [Penalty] = []
    @State private var isDQ = false
    @State private var isNT = false
    @State private var showConfirm = false
    @State private var submitted = false

    private var penalties: [Penalty] { MockData.penalties(for: event.discipline) }
    private var scoringType: ScoringType { event.discipline.scoringType }

    var body: some View {
        NavigationStack {
            if submitted {
                ScoreSubmittedView(run: run) { dismiss() }
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        // Run info header
                        RunInfoHeader(run: run, event: event)

                        // Timer (not used for cutting)
                        if scoringType != .judgePoints {
                            RunTimerSection(state: $timerState, elapsed: $elapsed)
                        }

                        // Score input — discipline-specific
                        switch scoringType {
                        case .judgePoints:
                            CuttingScoreSection(score: $judgeScore)
                        case .cattleAndTime:
                            CattleAndTimeSection(cattleCount: $cattleCount, elapsed: elapsed, timeString: $timeString)
                        case .timeOnly:
                            TimeOnlySection(elapsed: elapsed, timeString: $timeString)
                        case .combined:
                            TimeOnlySection(elapsed: elapsed, timeString: $timeString)
                        }

                        // Penalties
                        PenaltySection(
                            penalties: penalties,
                            applied: $appliedPenalties,
                            isDQ: $isDQ,
                            isNT: $isNT
                        )

                        // Submit
                        RRButton(
                            title: isDQ ? "Submit — DQ" : isNT ? "Submit — NT" : "Submit score",
                            icon: "checkmark.circle.fill",
                            style: isDQ || isNT ? .destructive : .primary
                        ) {
                            showConfirm = true
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
                .navigationTitle("Score entry")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                }
                .confirmationDialog(
                    "Submit score for \(run.riderName)?",
                    isPresented: $showConfirm,
                    titleVisibility: .visible
                ) {
                    Button("Submit", role: .none) { submitScore() }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text(scoreSummary)
                }
            }
        }
    }

    private var scoreSummary: String {
        if isDQ { return "Result: Disqualified" }
        if isNT { return "Result: No Time" }
        switch scoringType {
        case .judgePoints:
            let deductions = appliedPenalties.reduce(0.0) { $0 + $1.value }
            return String(format: "Score: %.1f (%.1f - %.1f penalties)", judgeScore - deductions, judgeScore, deductions)
        case .cattleAndTime:
            let t = elapsed > 0 ? String(format: "%.3f", elapsed) : timeString
            return "\(cattleCount) head · \(t)s"
        default:
            return elapsed > 0 ? String(format: "Time: %.3f", elapsed) : "Time: \(timeString)"
        }
    }

    private func submitScore() {
        // Stop timer if running
        stopTimer()
        // TODO: POST to /api/scores
        submitted = true
    }

    // MARK: - Timer helpers
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        if timerState == .running { timerState = .stopped }
    }
}

// MARK: - Sub-sections

struct RunInfoHeader: View {
    let run: Run
    let event: Event
    var body: some View {
        RRCard {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        DisciplineBadge(discipline: event.discipline)
                        if let pos = run.drawPosition {
                            Text("Run #\(pos)").font(.rrTitle2).foregroundColor(.rrGold)
                        }
                    }
                    Text(run.riderName).font(.rrTitle3)
                    Text(run.horseName).font(.rrBodySm).foregroundColor(.secondary)
                    if let team = run.teamMembers {
                        Text(team.joined(separator: " · ")).font(.rrCaption).foregroundColor(.secondary)
                    }
                }
                Spacer()
                Text(run.division ?? "Open")
                    .font(.rrLabel)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Timer

enum TimerState { case idle, running, stopped }

struct RunTimerSection: View {
    @Binding var state: TimerState
    @Binding var elapsed: Double
    @State private var timer: Timer?

    var displayTime: String {
        let mins = Int(elapsed) / 60
        let secs = elapsed.truncatingRemainder(dividingBy: 60)
        if mins > 0 { return String(format: "%d:%06.3f", mins, secs) }
        return String(format: "%.3f", secs)
    }

    var body: some View {
        RRCard {
            VStack(spacing: 16) {
                Text(displayTime)
                    .font(.system(size: 52, weight: .bold, design: .monospaced))
                    .foregroundColor(state == .running ? .rrGold : .primary)
                    .monospacedDigit()

                HStack(spacing: 16) {
                    switch state {
                    case .idle:
                        RRButton(title: "Start", icon: "play.fill", style: .primary) { start() }
                    case .running:
                        RRButton(title: "Stop", icon: "stop.fill", style: .destructive) { stop() }
                    case .stopped:
                        RRButton(title: "Reset", icon: "arrow.counterclockwise", style: .secondary) { reset() }
                        RRButton(title: "Re-start", icon: "play.fill", style: .primary) { start() }
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    func start() {
        state = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            elapsed += 0.01
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        state = .stopped
    }

    func reset() {
        elapsed = 0
        state = .idle
    }
}

// MARK: - Cutting score (judge points)

struct CuttingScoreSection: View {
    @Binding var score: Double
    private let range = 60.0...80.0
    private let step = 0.5

    var body: some View {
        RRCard {
            VStack(spacing: 16) {
                Text("Judge score")
                    .font(.rrLabel)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(String(format: "%.1f", score))
                    .font(.system(size: 56, weight: .bold, design: .rounded))
                    .foregroundColor(.rrGold)

                Slider(value: $score, in: range, step: step)
                    .tint(.rrGold)

                HStack {
                    Text("60.0").font(.rrCaption).foregroundColor(.secondary)
                    Spacer()
                    Text("80.0").font(.rrCaption).foregroundColor(.secondary)
                }

                // Fine-tune buttons
                HStack(spacing: 12) {
                    ForEach([-1.0, -0.5, 0.5, 1.0], id: \.self) { delta in
                        Button {
                            score = max(60, min(80, score + delta))
                        } label: {
                            Text(delta > 0 ? "+\(String(format: "%.1f", delta))" : String(format: "%.1f", delta))
                                .font(.rrLabel)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(delta > 0 ? Color.rrSuccess.opacity(0.12) : Color.rrDanger.opacity(0.12))
                                .foregroundColor(delta > 0 ? .rrSuccess : .rrDanger)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Cattle count + time (penning / sorting)

struct CattleAndTimeSection: View {
    @Binding var cattleCount: Int
    let elapsed: Double
    @Binding var timeString: String

    var body: some View {
        RRCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("Cattle counted")
                    .font(.rrLabel)
                    .foregroundColor(.secondary)

                HStack(spacing: 0) {
                    ForEach(0...5, id: \.self) { count in
                        Button {
                            cattleCount = count
                        } label: {
                            Text("\(count)")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(cattleCount == count ? Color.rrNavy : Color(UIColor.tertiarySystemBackground))
                                .foregroundColor(cattleCount == count ? .white : .primary)
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.separator), lineWidth: 0.5))

                if elapsed == 0 {
                    RRTextField(label: "Time (if not using timer)", text: $timeString,
                                placeholder: "e.g. 74.200",
                                keyboardType: .decimalPad)
                }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Time only (barrel racing)

struct TimeOnlySection: View {
    let elapsed: Double
    @Binding var timeString: String

    var body: some View {
        if elapsed == 0 {
            RRCard {
                RRTextField(label: "Time (if not using timer)", text: $timeString,
                            placeholder: "e.g. 15.823",
                            keyboardType: .decimalPad)
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Penalties panel

struct PenaltySection: View {
    let penalties: [Penalty]
    @Binding var applied: [Penalty]
    @Binding var isDQ: Bool
    @Binding var isNT: Bool

    var body: some View {
        RRCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Penalties").font(.rrLabel).foregroundColor(.secondary)

                ForEach(penalties) { penalty in
                    let isApplied = applied.contains { $0.id == penalty.id }
                    Button {
                        toggle(penalty)
                    } label: {
                        HStack {
                            Image(systemName: isApplied ? "checkmark.square.fill" : "square")
                                .foregroundColor(isApplied ? .rrDanger : .secondary)
                                .font(.system(size: 20))

                            Text(penalty.name).font(.rrBody)
                                .foregroundColor(isApplied ? .rrDanger : .primary)

                            Spacer()

                            switch penalty.type {
                            case .seconds:
                                Text("+\(Int(penalty.value))s")
                                    .font(.rrLabel)
                                    .foregroundColor(.rrWarning)
                            case .points:
                                Text("-\(Int(penalty.value)) pts")
                                    .font(.rrLabel)
                                    .foregroundColor(.rrWarning)
                            case .disqualification:
                                Text("DQ").font(.rrLabel).foregroundColor(.rrDanger)
                            case .noTime:
                                Text("NT").font(.rrLabel).foregroundColor(.rrDanger)
                            case .reRide:
                                Text("RE").font(.rrLabel).foregroundColor(.rrInfo)
                            }
                        }
                    }
                    .buttonStyle(.plain)

                    if penalty !== penalties.last {
                        Divider()
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    private func toggle(_ penalty: Penalty) {
        if penalty.type == .disqualification {
            isDQ.toggle()
            applied.removeAll { $0.id == penalty.id }
            return
        }
        if penalty.type == .noTime {
            isNT.toggle()
            applied.removeAll { $0.id == penalty.id }
            return
        }
        if applied.contains(where: { $0.id == penalty.id }) {
            applied.removeAll { $0.id == penalty.id }
        } else {
            applied.append(penalty)
        }
    }
}

extension Array {
    // Safe `!==` for reference comparison used in ForEach loop above
}

struct ScoreSubmittedView: View {
    let run: Run
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 72))
                .foregroundColor(.rrSuccess)
            Text("Score submitted").font(.rrTitle)
            Text("\(run.riderName) · \(run.horseName)")
                .font(.rrBody)
                .foregroundColor(.secondary)
            Text("The leaderboard will update in real time.")
                .font(.rrBodySm)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            RRButton(title: "Next run", icon: "arrow.right", action: onDone)
                .padding(.horizontal, 32)
            Spacer()
        }
    }
}
