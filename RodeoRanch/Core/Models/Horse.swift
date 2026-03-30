import Foundation

struct Horse: Identifiable, Codable {
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
}

enum HorseSex: String, Codable, CaseIterable {
    case mare
    case gelding
    case stallion

    var displayName: String {
        switch self {
        case .mare: return "Mare"
        case .gelding: return "Gelding"
        case .stallion: return "Stallion"
        }
    }
}
