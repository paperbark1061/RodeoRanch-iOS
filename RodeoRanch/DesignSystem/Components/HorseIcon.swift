import SwiftUI

/// Custom horse silhouette drawn as a single continuous filled outline.
/// Based on a 100×100 grid. Drawn as one closed path so it reads cleanly
/// at any size — including 26px tab bar icons.
struct HorseShape: Shape {
    func path(in rect: CGRect) -> Path {
        let sx = rect.width  / 100
        let sy = rect.height / 100

        func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(x: x * sx, y: y * sy)
        }

        var p = Path()

        // Start at nose tip and trace the full outline clockwise:
        // nose → forehead → poll/ear → neck crest → withers → back →
        // rump → tail → hindquarters → hind legs → belly → front legs →
        // chest → throatlatch → back to nose

        // Nose
        p.move(to: pt(12, 38))

        // Muzzle / nose bridge curve up to forehead
        p.addCurve(to: pt(16, 22),
                   control1: pt(9, 34),
                   control2: pt(10, 26))

        // Forehead up to poll
        p.addCurve(to: pt(22, 12),
                   control1: pt(19, 19),
                   control2: pt(20, 14))

        // Ear (sharp point)
        p.addLine(to: pt(20,  4))
        p.addLine(to: pt(27,  9))

        // Poll down into neck crest
        p.addCurve(to: pt(38, 18),
                   control1: pt(28, 10),
                   control2: pt(34, 15))

        // Neck crest sweeping to withers
        p.addCurve(to: pt(55, 22),
                   control1: pt(44, 18),
                   control2: pt(50, 20))

        // Withers dip
        p.addCurve(to: pt(62, 24),
                   control1: pt(58, 21),
                   control2: pt(60, 22))

        // Back — slight hollow
        p.addCurve(to: pt(80, 26),
                   control1: pt(70, 22),
                   control2: pt(76, 23))

        // Rump — rounded high point
        p.addCurve(to: pt(90, 34),
                   control1: pt(85, 25),
                   control2: pt(90, 28))

        // Tail base
        p.addCurve(to: pt(93, 42),
                   control1: pt(91, 37),
                   control2: pt(93, 39))

        // Tail flowing up and out
        p.addCurve(to: pt(100, 28),
                   control1: pt(96, 40),
                   control2: pt(102, 34))
        p.addCurve(to: pt(94, 22),
                   control1: pt(99, 24),
                   control2: pt(96, 22))
        p.addCurve(to: pt(91, 36),
                   control1: pt(91, 23),
                   control2: pt(90, 30))

        // Back of hindquarters dropping down
        p.addCurve(to: pt(88, 52),
                   control1: pt(91, 41),
                   control2: pt(90, 47))

        // Hind leg 1 (right, extended back)
        p.addLine(to: pt(86, 52))
        p.addCurve(to: pt(82, 68),
                   control1: pt(85, 58),
                   control2: pt(84, 63))
        p.addCurve(to: pt(80, 80),
                   control1: pt(81, 72),
                   control2: pt(80, 76))
        // Hoof
        p.addLine(to: pt(80, 86))
        p.addLine(to: pt(85, 88))
        p.addLine(to: pt(85, 90))
        p.addLine(to: pt(76, 90))
        p.addLine(to: pt(76, 88))
        p.addLine(to: pt(78, 87))
        p.addCurve(to: pt(76, 72),
                   control1: pt(77, 84),
                   control2: pt(76, 78))
        p.addCurve(to: pt(72, 58),
                   control1: pt(75, 66),
                   control2: pt(73, 62))
        p.addLine(to: pt(70, 54))

        // Belly curve forward
        p.addCurve(to: pt(38, 56),
                   control1: pt(62, 58),
                   control2: pt(50, 58))

        // Front leg 1 (left, extended forward)
        p.addLine(to: pt(36, 56))
        p.addCurve(to: pt(28, 72),
                   control1: pt(34, 62),
                   control2: pt(29, 67))
        p.addCurve(to: pt(24, 84),
                   control1: pt(27, 77),
                   control2: pt(24, 80))
        // Hoof
        p.addLine(to: pt(22, 88))
        p.addLine(to: pt(16, 88))
        p.addLine(to: pt(16, 86))
        p.addLine(to: pt(21, 86))
        p.addCurve(to: pt(26, 70),
                   control1: pt(23, 83),
                   control2: pt(26, 76))
        p.addCurve(to: pt(32, 55),
                   control1: pt(27, 64),
                   control2: pt(30, 59))

        // Second front leg (slightly behind, tucked)
        p.addLine(to: pt(34, 55))
        p.addCurve(to: pt(30, 70),
                   control1: pt(34, 62),
                   control2: pt(31, 66))
        p.addCurve(to: pt(30, 82),
                   control1: pt(29, 75),
                   control2: pt(29, 79))
        // Hoof
        p.addLine(to: pt(28, 88))
        p.addLine(to: pt(34, 88))
        p.addLine(to: pt(35, 86))
        p.addLine(to: pt(33, 86))
        p.addCurve(to: pt(36, 70),
                   control1: pt(34, 81),
                   control2: pt(36, 75))
        p.addCurve(to: pt(38, 56),
                   control1: pt(37, 64),
                   control2: pt(38, 60))

        // Chest curve up
        p.addCurve(to: pt(36, 44),
                   control1: pt(36, 52),
                   control2: pt(35, 48))

        // Hind leg 2 (slightly in front, tucked)
        p.addLine(to: pt(70, 54))
        p.addLine(to: pt(72, 54))
        p.addCurve(to: pt(74, 68),
                   control1: pt(73, 59),
                   control2: pt(74, 63))
        p.addCurve(to: pt(72, 82),
                   control1: pt(74, 74),
                   control2: pt(73, 78))
        // Hoof
        p.addLine(to: pt(70, 88))
        p.addLine(to: pt(76, 88))
        p.addLine(to: pt(77, 86))
        p.addLine(to: pt(73, 86))
        p.addCurve(to: pt(70, 72),
                   control1: pt(73, 83),
                   control2: pt(71, 77))
        p.addCurve(to: pt(68, 58),
                   control1: pt(69, 66),
                   control2: pt(68, 62))

        // Chest / lower neck
        p.addCurve(to: pt(28, 44),
                   control1: pt(32, 44),
                   control2: pt(30, 44))

        // Throatlatch back up to jaw
        p.addCurve(to: pt(20, 36),
                   control1: pt(24, 44),
                   control2: pt(20, 40))

        // Jaw back to nose
        p.addCurve(to: pt(12, 38),
                   control1: pt(18, 34),
                   control2: pt(14, 36))

        p.closeSubpath()
        return p
    }
}

/// Convenience view — same usage as Image(systemName:).
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
