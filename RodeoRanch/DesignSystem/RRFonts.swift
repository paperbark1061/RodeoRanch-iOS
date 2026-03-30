import SwiftUI

/// Typography system using system fonts scaled to match the Barlow Condensed / Sora
/// visual weight from the web platform. Swap to custom fonts here if needed.
extension Font {
    // Display / headings (Barlow Condensed equivalent)
    static let rrDisplay = Font.system(size: 32, weight: .bold, design: .rounded)
    static let rrTitle   = Font.system(size: 24, weight: .bold, design: .rounded)
    static let rrTitle2  = Font.system(size: 20, weight: .semibold, design: .rounded)
    static let rrTitle3  = Font.system(size: 17, weight: .semibold, design: .rounded)

    // Body / UI (Sora equivalent)
    static let rrBody    = Font.system(size: 16, weight: .regular)
    static let rrBodySm  = Font.system(size: 14, weight: .regular)
    static let rrCaption = Font.system(size: 12, weight: .regular)
    static let rrLabel   = Font.system(size: 13, weight: .medium)
}
