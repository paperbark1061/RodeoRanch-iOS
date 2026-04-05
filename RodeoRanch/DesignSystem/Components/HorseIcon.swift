import SwiftUI

/// Thin wrapper around SF Symbols' built-in horse head icon.
/// Use this everywhere instead of a custom drawn shape.
/// The SF Symbol "horse.fill" is a clean horse head profile
/// that renders perfectly at any size including 26px tab bars.
struct HorseIcon: View {
    var size: CGFloat = 24
    var color: Color = .primary

    var body: some View {
        Image(systemName: "horse.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(color)
            .frame(width: size, height: size)
    }
}

/// HorseShape is no longer needed — SF Symbols horse.fill replaces it.
/// Kept as a typealias stub so any remaining references compile cleanly.
typealias HorseShape = _HorseShapeStub
struct _HorseShapeStub: Shape {
    func path(in rect: CGRect) -> Path { Path() }
}
