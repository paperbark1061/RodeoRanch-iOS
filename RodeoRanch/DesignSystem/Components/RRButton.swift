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
        case .secondary:   return Color(hex: "#f3f4f6")
        case .destructive: return .rrDanger
        case .ghost:       return .clear
        }
    }

    private var fgColor: Color {
        switch style {
        case .primary, .destructive: return .white
        case .secondary:             return .rrNavy
        case .ghost:                 return .rrNavy
        }
    }

    private var borderColor: Color {
        switch style {
        case .secondary: return Color(hex: "#d1d5db")
        case .ghost:     return Color(hex: "#d1d5db")
        default:         return .clear
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView().tint(fgColor)
                } else {
                    if let icon {
                        Image(systemName: icon)
                            .foregroundColor(fgColor)
                    }
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(fgColor)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
        .disabled(isLoading)
    }
}
