import Foundation

struct User: Identifiable, Codable {
    let id: String
    var firstName: String
    var lastName: String
    var email: String
    var phone: String?
    var membershipNumber: String?
    var roles: [UserRole]
    var clubId: String?
    var clubName: String?
    var region: Region
    var avatarURL: String?
    var createdAt: Date

    var fullName: String { "\(firstName) \(lastName)" }
    var isJudge: Bool { roles.contains(.judge) }
    var isRider: Bool { roles.contains(.rider) }
}

enum UserRole: String, Codable, CaseIterable {
    case rider
    case judge
    case clubAdmin = "club_admin"
    case eventAdmin = "event_admin"
    case superAdmin = "super_admin"
}

enum Region: String, Codable, CaseIterable {
    case nsw = "NSW"
    case qld = "QLD"
    case vic = "VIC"
    case sa = "SA"
    case wa = "WA"
    case tas = "TAS"
    case act = "ACT"
    case nt = "NT"
    case nz = "NZ"
    case usaTx = "USA-TX"
    case usaCo = "USA-CO"
    case usaCa = "USA-CA"
    case canAb = "CAN-AB"

    var displayName: String { rawValue }
}
