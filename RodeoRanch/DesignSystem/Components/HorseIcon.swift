import SwiftUI

/// HorseIcon — used in list rows and cards throughout the app.
/// The tab bar now uses SF Symbols "horse.fill" directly, so this
/// is only needed for in-app usage (horse list avatars etc.)
struct HorseIcon: View {
    var size: CGFloat = 24
    var color: Color = .rrNavy

    var body: some View {
        Image(systemName: "horse.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(color)
            .frame(width: size, height: size)
    }
}
