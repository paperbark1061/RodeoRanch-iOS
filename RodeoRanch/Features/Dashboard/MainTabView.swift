import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var authState: AuthState

    var body: some View {
        TabView(selection: $router.selectedTab) {
            DashboardView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(AppTab.dashboard)

            EventsView()
                .tabItem { Label("Events", systemImage: "calendar") }
                .tag(AppTab.events)

            MyRunsView()
                .tabItem { Label("My Runs", systemImage: "timer") }
                .tag(AppTab.myRuns)

            HorsesView()
                .tabItem {
                    // Tab items only support Image/Label, not arbitrary views.
                    // We render the custom HorseShape into a UIImage at tab-bar size.
                    Label {
                        Text("Horses")
                    } icon: {
                        Image(uiImage: HorseShape.uiImage(size: 24))
                            .renderingMode(.template)
                    }
                }
                .tag(AppTab.horses)

            StandingsView()
                .tabItem { Label("Standings", systemImage: "list.number") }
                .tag(AppTab.standings)

            if authState.currentUser?.isJudge == true {
                JudgeModeView()
                    .tabItem { Label("Judge", systemImage: "stopwatch.fill") }
                    .tag(AppTab.judge)
            }

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.circle") }
                .tag(AppTab.profile)
        }
        .tint(.rrNavy)
    }
}
