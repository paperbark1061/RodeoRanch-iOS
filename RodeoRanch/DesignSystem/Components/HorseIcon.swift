import SwiftUI

/// Custom running horse silhouette used wherever SF Symbols would show a rabbit.
/// Renders as a scalable SwiftUI Shape so it works at any size and respects foregroundColor.
struct HorseShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width  / 100
        let h = rect.height / 100
        var p = Path()

        // Body
        p.move(to:    CGPoint(x: 30*w, y: 55*h))
        p.addCurve(to: CGPoint(x: 70*w, y: 45*h),
                   control1: CGPoint(x: 42*w, y: 48*h),
                   control2: CGPoint(x: 58*w, y: 44*h))
        p.addCurve(to: CGPoint(x: 85*w, y: 52*h),
                   control1: CGPoint(x: 78*w, y: 45*h),
                   control2: CGPoint(x: 84*w, y: 48*h))
        p.addCurve(to: CGPoint(x: 80*w, y: 62*h),
                   control1: CGPoint(x: 86*w, y: 56*h),
                   control2: CGPoint(x: 84*w, y: 60*h))
        p.addCurve(to: CGPoint(x: 72*w, y: 65*h),
                   control1: CGPoint(x: 77*w, y: 64*h),
                   control2: CGPoint(x: 75*w, y: 65*h))
        p.addCurve(to: CGPoint(x: 60*w, y: 60*h),
                   control1: CGPoint(x: 67*w, y: 65*h),
                   control2: CGPoint(x: 63*w, y: 62*h))
        p.addCurve(to: CGPoint(x: 30*w, y: 62*h),
                   control1: CGPoint(x: 50*w, y: 57*h),
                   control2: CGPoint(x: 40*w, y: 60*h))
        p.addCurve(to: CGPoint(x: 30*w, y: 55*h),
                   control1: CGPoint(x: 26*w, y: 61*h),
                   control2: CGPoint(x: 26*w, y: 57*h))
        p.closeSubpath()

        // Neck
        p.move(to:    CGPoint(x: 30*w, y: 55*h))
        p.addCurve(to: CGPoint(x: 25*w, y: 35*h),
                   control1: CGPoint(x: 24*w, y: 50*h),
                   control2: CGPoint(x: 22*w, y: 42*h))
        p.addCurve(to: CGPoint(x: 35*w, y: 30*h),
                   control1: CGPoint(x: 27*w, y: 30*h),
                   control2: CGPoint(x: 31*w, y: 29*h))
        p.addCurve(to: CGPoint(x: 40*w, y: 50*h),
                   control1: CGPoint(x: 40*w, y: 36*h),
                   control2: CGPoint(x: 41*w, y: 44*h))
        p.addCurve(to: CGPoint(x: 30*w, y: 55*h),
                   control1: CGPoint(x: 38*w, y: 53*h),
                   control2: CGPoint(x: 34*w, y: 55*h))
        p.closeSubpath()

        // Head
        p.move(to:    CGPoint(x: 25*w, y: 35*h))
        p.addCurve(to: CGPoint(x: 18*w, y: 22*h),
                   control1: CGPoint(x: 20*w, y: 32*h),
                   control2: CGPoint(x: 17*w, y: 28*h))
        p.addCurve(to: CGPoint(x: 24*w, y: 14*h),
                   control1: CGPoint(x: 19*w, y: 17*h),
                   control2: CGPoint(x: 21*w, y: 14*h))
        p.addCurve(to: CGPoint(x: 32*w, y: 18*h),
                   control1: CGPoint(x: 27*w, y: 14*h),
                   control2: CGPoint(x: 30*w, y: 15*h))
        p.addCurve(to: CGPoint(x: 35*w, y: 30*h),
                   control1: CGPoint(x: 36*w, y: 23*h),
                   control2: CGPoint(x: 36*w, y: 27*h))
        p.addCurve(to: CGPoint(x: 25*w, y: 35*h),
                   control1: CGPoint(x: 33*w, y: 33*h),
                   control2: CGPoint(x: 29*w, y: 35*h))
        p.closeSubpath()

        // Ear
        p.move(to:    CGPoint(x: 26*w, y: 14*h))
        p.addLine(to: CGPoint(x: 24*w, y:  7*h))
        p.addLine(to: CGPoint(x: 30*w, y: 10*h))
        p.addLine(to: CGPoint(x: 32*w, y: 18*h))
        p.closeSubpath()

        // Mane
        p.move(to:    CGPoint(x: 32*w, y: 18*h))
        p.addCurve(to: CGPoint(x: 42*w, y: 28*h),
                   control1: CGPoint(x: 38*w, y: 18*h),
                   control2: CGPoint(x: 43*w, y: 22*h))
        p.addCurve(to: CGPoint(x: 36*w, y: 32*h),
                   control1: CGPoint(x: 41*w, y: 31*h),
                   control2: CGPoint(x: 38*w, y: 32*h))
        p.addCurve(to: CGPoint(x: 29*w, y: 22*h),
                   control1: CGPoint(x: 33*w, y: 31*h),
                   control2: CGPoint(x: 30*w, y: 27*h))
        p.closeSubpath()

        // Front leg extended
        p.move(to:    CGPoint(x: 35*w, y: 62*h))
        p.addCurve(to: CGPoint(x: 28*w, y: 82*h),
                   control1: CGPoint(x: 33*w, y: 70*h),
                   control2: CGPoint(x: 28*w, y: 76*h))
        p.addLine(to: CGPoint(x: 24*w, y: 88*h))
        p.addLine(to: CGPoint(x: 20*w, y: 90*h))
        p.addLine(to: CGPoint(x: 20*w, y: 86*h))
        p.addLine(to: CGPoint(x: 23*w, y: 84*h))
        p.addCurve(to: CGPoint(x: 30*w, y: 62*h),
                   control1: CGPoint(x: 25*w, y: 77*h),
                   control2: CGPoint(x: 28*w, y: 70*h))
        p.closeSubpath()

        // Front leg tucked
        p.move(to:    CGPoint(x: 40*w, y: 63*h))
        p.addCurve(to: CGPoint(x: 36*w, y: 80*h),
                   control1: CGPoint(x: 40*w, y: 71*h),
                   control2: CGPoint(x: 37*w, y: 76*h))
        p.addLine(to: CGPoint(x: 34*w, y: 86*h))
        p.addLine(to: CGPoint(x: 30*w, y: 88*h))
        p.addLine(to: CGPoint(x: 30*w, y: 84*h))
        p.addLine(to: CGPoint(x: 33*w, y: 82*h))
        p.addCurve(to: CGPoint(x: 37*w, y: 63*h),
                   control1: CGPoint(x: 35*w, y: 75*h),
                   control2: CGPoint(x: 37*w, y: 69*h))
        p.closeSubpath()

        // Hind leg extended
        p.move(to:    CGPoint(x: 68*w, y: 63*h))
        p.addCurve(to: CGPoint(x: 74*w, y: 78*h),
                   control1: CGPoint(x: 70*w, y: 70*h),
                   control2: CGPoint(x: 73*w, y: 74*h))
        p.addLine(to: CGPoint(x: 78*w, y: 88*h))
        p.addLine(to: CGPoint(x: 82*w, y: 90*h))
        p.addLine(to: CGPoint(x: 82*w, y: 86*h))
        p.addLine(to: CGPoint(x: 79*w, y: 84*h))
        p.addCurve(to: CGPoint(x: 73*w, y: 63*h),
                   control1: CGPoint(x: 76*w, y: 77*h),
                   control2: CGPoint(x: 74*w, y: 70*h))
        p.closeSubpath()

        // Hind leg tucked
        p.move(to:    CGPoint(x: 62*w, y: 63*h))
        p.addCurve(to: CGPoint(x: 65*w, y: 80*h),
                   control1: CGPoint(x: 63*w, y: 71*h),
                   control2: CGPoint(x: 64*w, y: 76*h))
        p.addLine(to: CGPoint(x: 66*w, y: 88*h))
        p.addLine(to: CGPoint(x: 70*w, y: 90*h))
        p.addLine(to: CGPoint(x: 70*w, y: 86*h))
        p.addLine(to: CGPoint(x: 67*w, y: 84*h))
        p.addCurve(to: CGPoint(x: 64*w, y: 63*h),
                   control1: CGPoint(x: 65*w, y: 76*h),
                   control2: CGPoint(x: 64*w, y: 70*h))
        p.closeSubpath()

        // Tail
        p.move(to:    CGPoint(x: 80*w, y: 55*h))
        p.addCurve(to: CGPoint(x: 95*w, y: 38*h),
                   control1: CGPoint(x: 88*w, y: 52*h),
                   control2: CGPoint(x: 98*w, y: 46*h))
        p.addCurve(to: CGPoint(x: 88*w, y: 32*h),
                   control1: CGPoint(x: 93*w, y: 33*h),
                   control2: CGPoint(x: 90*w, y: 31*h))
        p.addCurve(to: CGPoint(x: 78*w, y: 48*h),
                   control1: CGPoint(x: 85*w, y: 34*h),
                   control2: CGPoint(x: 80*w, y: 40*h))
        p.addCurve(to: CGPoint(x: 80*w, y: 55*h),
                   control1: CGPoint(x: 77*w, y: 52*h),
                   control2: CGPoint(x: 78*w, y: 54*h))
        p.closeSubpath()

        return p
    }
}

/// Convenience view — use anywhere in the hierarchy.
/// Example: HorseIcon(size: 24, color: .rrNavy)
struct HorseIcon: View {
    var size: CGFloat = 24
    var color: Color = .primary

    var body: some View {
        HorseShape()
            .fill(color)
            .frame(width: size, height: size)
    }
}
