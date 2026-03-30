import SwiftUI

/// RodeoRanch design system — Navy & Gold light theme + arena-ready dark contexts.
extension Color {
    // Primary palette
    static let rrNavy      = Color("rrNavy")       // #1a2744
    static let rrGold      = Color("rrGold")       // #d4a017
    static let rrGoldLight = Color("rrGoldLight")  // #f0c040

    // Backgrounds
    static let rrBg        = Color("rrBg")         // system background (adaptive)
    static let rrBg2       = Color("rrBg2")        // secondary surface
    static let rrBg3       = Color("rrBg3")        // tertiary / card bg

    // Text
    static let rrTextPrimary   = Color("rrTextPrimary")
    static let rrTextSecondary = Color("rrTextSecondary")

    // Discipline colours
    static let discGold   = Color(hex: "#d4a017")  // Team Penning
    static let discBlue   = Color(hex: "#2563eb")  // Cutting
    static let discPurple = Color(hex: "#7c3aed")  // Sorting
    static let discGreen  = Color(hex: "#16a34a")  // Barrel Racing
    static let discTeal   = Color(hex: "#0e7a6a")  // Rodeo

    // Status
    static let rrSuccess  = Color(hex: "#16a34a")
    static let rrWarning  = Color(hex: "#d97706")
    static let rrDanger   = Color(hex: "#dc2626")
    static let rrInfo     = Color(hex: "#2563eb")

    // Stripe (third-party brand — do not alter)
    static let stripePurple = Color(hex: "#635bff")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255, opacity: Double(a)/255)
    }
}
