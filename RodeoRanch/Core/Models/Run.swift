import Foundation

struct Run: Identifiable, Codable {
    let id: String
    var eventId: String
    var eventName: String
    var discipline: Discipline
    var riderId: String
    var riderName: String
    var horseName: String
    var horseId: String
    var drawPosition: Int?
    var scheduledTime: Date?
    var status: RunStatus
    var result: RunResult?
    var division: String?
    var teamMembers: [String]?
}

enum RunStatus: String, Codable {
    case upcoming
    case onDeck = "on_deck"  // next up
    case inProgress = "in_progress"
    case completed
    case scratched
    case noTime = "no_time"
}

struct RunResult: Codable {
    var time: Double?           // seconds, nil for NT
    var cattleCount: Int?       // penning / sorting
    var judgeScore: Double?     // cutting (60–80)
    var penalties: [Penalty]
    var placing: Int?
    var division: String?
    var prizeAmount: Double?
    var pointsEarned: Double?

    var displayTime: String {
        guard let t = time else { return "NT" }
        let mins = Int(t) / 60
        let secs = t.truncatingRemainder(dividingBy: 60)
        if mins > 0 {
            return String(format: "%d:%06.3f", mins, secs)
        }
        return String(format: "%.3f", secs)
    }
}

struct Penalty: Codable, Identifiable {
    let id: String
    var name: String
    var type: PenaltyType
    var value: Double
}

enum PenaltyType: String, Codable {
    case seconds
    case points
    case disqualification = "DQ"
    case noTime = "NT"
    case reRide = "RE"
}
