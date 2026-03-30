import Foundation

struct StandingsEntry: Identifiable, Codable {
    let id: String
    var placing: Int
    var riderName: String
    var horseName: String
    var division: String
    var score: String          // formatted for display (time string or points)
    var penalties: Double?
    var teamName: String?
    var isCurrentUser: Bool
}

struct Leaderboard: Identifiable, Codable {
    let id: String
    var eventId: String
    var eventName: String
    var discipline: Discipline
    var division: String
    var entries: [StandingsEntry]
    var lastUpdated: Date
}
