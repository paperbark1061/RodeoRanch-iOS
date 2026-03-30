import Foundation

struct Event: Identifiable, Codable {
    let id: String
    var name: String
    var discipline: Discipline
    var status: EventStatus
    var startDate: Date
    var endDate: Date
    var venue: String
    var region: Region
    var entryFee: Double
    var maxEntries: Int
    var currentEntries: Int
    var description: String?
    var drawReleased: Bool
    var resultsPosted: Bool

    var entryPercentage: Double {
        guard maxEntries > 0 else { return 0 }
        return Double(currentEntries) / Double(maxEntries)
    }

    var isFull: Bool { currentEntries >= maxEntries }
    var isLive: Bool { status == .live }
}

enum EventStatus: String, Codable, CaseIterable {
    case open
    case live
    case closed
    case cancelled
    case resultsPosted = "results_posted"

    var displayName: String {
        switch self {
        case .open: return "Open"
        case .live: return "Live"
        case .closed: return "Closed"
        case .cancelled: return "Cancelled"
        case .resultsPosted: return "Results"
        }
    }
}

enum Discipline: String, Codable, CaseIterable {
    case teamPenning = "team_penning"
    case cutting
    case sorting
    case barrelRacing = "barrel_racing"
    case rodeo

    var displayName: String {
        switch self {
        case .teamPenning: return "Team Penning"
        case .cutting: return "Cutting"
        case .sorting: return "Sorting"
        case .barrelRacing: return "Barrel Racing"
        case .rodeo: return "Rodeo"
        }
    }

    var shortCode: String {
        switch self {
        case .teamPenning: return "TP"
        case .cutting: return "CUT"
        case .sorting: return "SORT"
        case .barrelRacing: return "BBL"
        case .rodeo: return "ROD"
        }
    }

    var colorName: String {
        switch self {
        case .teamPenning: return "discGold"
        case .cutting: return "discBlue"
        case .sorting: return "discPurple"
        case .barrelRacing: return "discGreen"
        case .rodeo: return "discTeal"
        }
    }

    /// Scoring type for judge mode
    var scoringType: ScoringType {
        switch self {
        case .teamPenning, .sorting: return .cattleAndTime
        case .cutting: return .judgePoints
        case .barrelRacing: return .timeOnly
        case .rodeo: return .combined
        }
    }
}

enum ScoringType {
    case cattleAndTime
    case judgePoints
    case timeOnly
    case combined
}
