import Foundation

struct Horse: Identifiable, Codable, Hashable {
    let id: String
    var name: String
    var registrationNumber: String?
    var breed: String?
    var colour: String?
    var sex: HorseSex
    var yearOfBirth: Int?
    var ownerId: String
    var ownerName: String
    var notes: String?
    var isActive: Bool
    var photoURL: String?

    // Hashable conformance — identity is the id
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Horse, rhs: Horse) -> Bool {
        lhs.id == rhs.id
    }
}

enum HorseSex: String, Codable, CaseIterable, Hashable {
    case mare
    case gelding
    case stallion

    var displayName: String {
        switch self {
        case .mare:     return "Mare"
        case .gelding:  return "Gelding"
        case .stallion: return "Stallion"
        }
    }
}
