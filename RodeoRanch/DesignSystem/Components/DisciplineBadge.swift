import SwiftUI

struct DisciplineBadge: View {
    let discipline: Discipline
    var size: BadgeSize = .regular

    enum BadgeSize { case small, regular, large }

    private var color: Color {
        switch discipline {
        case .teamPenning:  return .discGold
        case .cutting:      return .discBlue
        case .sorting:      return .discPurple
        case .barrelRacing: return .discGreen
        case .rodeo:        return .discTeal
        }
    }

    private var fontSize: CGFloat {
        switch size {
        case .small:   return 10
        case .regular: return 12
        case .large:   return 14
        }
    }

    private var padding: EdgeInsets {
        switch size {
        case .small:   return EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6)
        case .regular: return EdgeInsets(top: 3, leading: 8, bottom: 3, trailing: 8)
        case .large:   return EdgeInsets(top: 5, leading: 12, bottom: 5, trailing: 12)
        }
    }

    var body: some View {
        Text(discipline.shortCode)
            .font(.system(size: fontSize, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding(padding)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
