import SwiftUI
import UIKit

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var authState: AuthState

    init() {
        configureTabBarAppearance()
    }

    var body: some View {
        TabView(selection: $router.selectedTab) {
            DashboardView()
                .tabItem { Label("Home",      systemImage: "house.fill") }
                .tag(AppTab.dashboard)

            EventsView()
                .tabItem { Label("Events",    systemImage: "calendar") }
                .tag(AppTab.events)

            MyRunsView()
                .tabItem { Label("My Runs",   systemImage: "timer") }
                .tag(AppTab.myRuns)

            HorsesView()
                .tabItem { Label("Horses",    systemImage: "figure.equestrian.sports") }
                .tag(AppTab.horses)

            StandingsView()
                .tabItem { Label("Standings", systemImage: "list.number") }
                .tag(AppTab.standings)

            if authState.currentUser?.isJudge == true {
                JudgeModeView()
                    .tabItem { Label("Judge",  systemImage: "stopwatch.fill") }
                    .tag(AppTab.judge)
            }

            ProfileView()
                .tabItem { Label("Profile",   systemImage: "person.circle.fill") }
                .tag(AppTab.profile)
        }
    }

    /// Configures tab bar colours via UIKit so icons are always
    /// visible — navy when selected, mid-grey when unselected.
    private func configureTabBarAppearance() {
        let navy    = UIColor(red: 0.102, green: 0.153, blue: 0.267, alpha: 1) // #1a2744
        let midGrey = UIColor(red: 0.50,  green: 0.50,  blue: 0.55,  alpha: 1)

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        appearance.stackedLayoutAppearance.selected.iconColor = navy
        appearance.stackedLayoutAppearance.selected.titleTextAttributes =
            [.foregroundColor: navy]

        appearance.stackedLayoutAppearance.normal.iconColor = midGrey
        appearance.stackedLayoutAppearance.normal.titleTextAttributes =
            [.foregroundColor: midGrey]

        UITabBar.appearance().standardAppearance   = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
