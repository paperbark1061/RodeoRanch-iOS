import SwiftUI

/// Central navigation state — lets any screen deep-link to another tab or push a sheet.
class AppRouter: ObservableObject {
    @Published var selectedTab: AppTab = .dashboard
    @Published var presentedSheet: AppSheet?

    func navigate(to tab: AppTab) {
        selectedTab = tab
    }

    func present(_ sheet: AppSheet) {
        presentedSheet = sheet
    }

    func dismiss() {
        presentedSheet = nil
    }
}

enum AppTab: Int, Hashable {
    case dashboard
    case events
    case myRuns
    case horses
    case standings
    case judge
    case profile
}

enum AppSheet: Identifiable {
    case enterEvent(Event)
    case runDetail(Run)
    case addHorse
    case editProfile
    case notifications

    var id: String {
        switch self {
        case .enterEvent(let e): return "enter-\(e.id)"
        case .runDetail(let r): return "run-\(r.id)"
        case .addHorse: return "addHorse"
        case .editProfile: return "editProfile"
        case .notifications: return "notifications"
        }
    }
}
