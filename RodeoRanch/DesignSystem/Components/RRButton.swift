import SwiftUI

struct RRButton: View {
    let title: String
    var icon: String? = nil
    var style: ButtonStyle = .primary
    var isLoading: Bool = false
    let action: () -> Void

    enum ButtonStyle { case primary, secondary, destructive, ghost }

    private var bgColor: Color {
        switch style {
        case .primary:     return .rrNavy
        case .secondary:   return Color(UIColor.secondarySystemBackground)
        case .destructive: return .rrDanger
        case .ghost:       return .clear
        }
    }

    private var fgColor: Color {
        switch style {
        case .primary, .destructive: return .white
        case .secondary, .ghost: return .rrNavy
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView().tint(fgColor)
                } else {
                    if let icon { Image(systemName: icon) }
                    Text(title).fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .foregroundColor(fgColor)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .disabled(isLoading)
    }
}
