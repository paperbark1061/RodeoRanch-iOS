import SwiftUI

struct EventStatusBadge: View {
    let status: EventStatus

    private var color: Color {
        switch status {
        case .open:          return .rrInfo
        case .live:          return .rrSuccess
        case .closed:        return .secondary
        case .cancelled:     return .rrDanger
        case .resultsPosted: return .rrGold
        }
    }

    var body: some View {
        HStack(spacing: 4) {
            if status == .live {
                Circle()
                    .fill(Color.rrSuccess)
                    .frame(width: 6, height: 6)
                    .modifier(PulsingModifier())
            }
            Text(status.displayName)
                .font(.rrCaption)
                .fontWeight(.semibold)
        }
        .foregroundColor(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(color.opacity(0.12))
        .clipShape(Capsule())
    }
}

struct PulsingModifier: ViewModifier {
    @State private var pulse = false
    func body(content: Content) -> some View {
        content
            .scaleEffect(pulse ? 1.4 : 1.0)
            .opacity(pulse ? 0.5 : 1.0)
            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: pulse)
            .onAppear { pulse = true }
    }
}
