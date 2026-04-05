import SwiftUI
import UIKit

// MARK: - Horse head shape
// A bold front-facing horse head silhouette.
// Drawn on a 100×100 grid. Reads cleanly at 26pt tab bar size.
struct HorseShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width  / 100
        let h = rect.height / 100
        var p = Path()

        // ---- Outer head / face outline (clockwise) ----
        // Start at bottom-left of jaw
        p.move(to: CGPoint(x: 24*w, y: 88*h))

        // Left jaw up to cheek
        p.addCurve(to: CGPoint(x: 20*w, y: 68*h),
                   control1: CGPoint(x: 20*w, y: 85*h),
                   control2: CGPoint(x: 18*w, y: 76*h))

        // Left cheek up to eye socket
        p.addCurve(to: CGPoint(x: 22*w, y: 50*h),
                   control1: CGPoint(x: 20*w, y: 62*h),
                   control2: CGPoint(x: 20*w, y: 56*h))

        // Left temple curving to forehead
        p.addCurve(to: CGPoint(x: 30*w, y: 30*h),
                   control1: CGPoint(x: 22*w, y: 44*h),
                   control2: CGPoint(x: 24*w, y: 36*h))

        // Forehead left to poll
        p.addCurve(to: CGPoint(x: 38*w, y: 14*h),
                   control1: CGPoint(x: 32*w, y: 26*h),
                   control2: CGPoint(x: 34*w, y: 18*h))

        // Left ear (sharp upward spike)
        p.addLine(to: CGPoint(x: 34*w, y:  4*h))   // ear tip
        p.addLine(to: CGPoint(x: 42*w, y: 12*h))   // inner base

        // Poll (top of head, between ears)
        p.addCurve(to: CGPoint(x: 58*w, y: 12*h),
                   control1: CGPoint(x: 46*w, y:  8*h),
                   control2: CGPoint(x: 54*w, y:  8*h))

        // Right ear
        p.addLine(to: CGPoint(x: 66*w, y:  4*h))   // ear tip
        p.addLine(to: CGPoint(x: 62*w, y: 14*h))   // inner base

        // Forehead right side down
        p.addCurve(to: CGPoint(x: 70*w, y: 30*h),
                   control1: CGPoint(x: 66*w, y: 18*h),
                   control2: CGPoint(x: 68*w, y: 26*h))

        // Right temple
        p.addCurve(to: CGPoint(x: 78*w, y: 50*h),
                   control1: CGPoint(x: 76*w, y: 36*h),
                   control2: CGPoint(x: 80*w, y: 44*h))

        // Right cheek
        p.addCurve(to: CGPoint(x: 80*w, y: 68*h),
                   control1: CGPoint(x: 80*w, y: 56*h),
                   control2: CGPoint(x: 82*w, y: 62*h))

        // Right jaw down to chin
        p.addCurve(to: CGPoint(x: 76*w, y: 88*h),
                   control1: CGPoint(x: 82*w, y: 76*h),
                   control2: CGPoint(x: 80*w, y: 84*h))

        // Chin / muzzle (slightly protruding bump)
        p.addCurve(to: CGPoint(x: 60*w, y: 94*h),
                   control1: CGPoint(x: 74*w, y: 92*h),
                   control2: CGPoint(x: 68*w, y: 96*h))
        p.addCurve(to: CGPoint(x: 50*w, y: 96*h),
                   control1: CGPoint(x: 57*w, y: 93*h),
                   control2: CGPoint(x: 54*w, y: 96*h))
        p.addCurve(to: CGPoint(x: 40*w, y: 94*h),
                   control1: CGPoint(x: 46*w, y: 96*h),
                   control2: CGPoint(x: 43*w, y: 93*h))
        p.addCurve(to: CGPoint(x: 24*w, y: 88*h),
                   control1: CGPoint(x: 32*w, y: 96*h),
                   control2: CGPoint(x: 26*w, y: 92*h))
        p.closeSubpath()

        // ---- Muzzle band (lighter inner area suggested by a cutout) ----
        // Adds a recessed muzzle plane for definition
        p.move(to: CGPoint(x: 36*w, y: 76*h))
        p.addCurve(to: CGPoint(x: 50*w, y: 80*h),
                   control1: CGPoint(x: 40*w, y: 82*h),
                   control2: CGPoint(x: 46*w, y: 82*h))
        p.addCurve(to: CGPoint(x: 64*w, y: 76*h),
                   control1: CGPoint(x: 54*w, y: 82*h),
                   control2: CGPoint(x: 60*w, y: 82*h))
        p.addCurve(to: CGPoint(x: 66*w, y: 68*h),
                   control1: CGPoint(x: 66*w, y: 74*h),
                   control2: CGPoint(x: 67*w, y: 70*h))
        p.addCurve(to: CGPoint(x: 50*w, y: 64*h),
                   control1: CGPoint(x: 64*w, y: 64*h),
                   control2: CGPoint(x: 58*w, y: 63*h))
        p.addCurve(to: CGPoint(x: 34*w, y: 68*h),
                   control1: CGPoint(x: 42*w, y: 63*h),
                   control2: CGPoint(x: 36*w, y: 64*h))
        p.addCurve(to: CGPoint(x: 36*w, y: 76*h),
                   control1: CGPoint(x: 33*w, y: 70*h),
                   control2: CGPoint(x: 34*w, y: 74*h))
        p.closeSubpath()

        return p
    }
}

// MARK: - HorseIcon view
/// Drop-in view. Usage: HorseIcon(size: 24, color: .rrNavy)
struct HorseIcon: View {
    var size: CGFloat = 24
    var color: Color = .primary

    var body: some View {
        HorseShape()
            .fill(color)
            .frame(width: size, height: size)
    }
}

// MARK: - Tab bar image
// Rendered once at launch. Uses UIGraphicsImageRenderer (no @MainActor needed).
// The even-odd fill rule punches the muzzle band out of the face, giving depth.
let horseTabUIImage: UIImage = {
    let size = CGSize(width: 26, height: 26)
    let renderer = UIGraphicsImageRenderer(size: size)
    let raw = renderer.image { ctx in
        let cgCtx = ctx.cgContext
        cgCtx.setFillColor(UIColor.black.cgColor)

        // Build the two sub-paths and fill with even-odd rule
        // so the muzzle oval punches a lighter hole in the face
        let shapePath = HorseShape()
            .path(in: CGRect(origin: .zero, size: size))
            .cgPath
        cgCtx.addPath(shapePath)
        cgCtx.fillPath(using: .evenOdd)
    }
    return raw.withRenderingMode(.alwaysTemplate)
}()
