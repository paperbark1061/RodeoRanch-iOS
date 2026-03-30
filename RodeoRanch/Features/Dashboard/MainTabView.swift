import SwiftUI
import UIKit

// Rendered once at app startup — avoids repeated rasterisation and
// sidesteps the tabItem closure compiler ambiguity entirely.
private let horseTabUIImage: UIImage = {
    let size = CGSize(width: 26, height: 26)
    let renderer = UIGraphicsImageRenderer(size: size)
    let raw = renderer.image { ctx in
        let path = HorseShape()
            .path(in: CGRect(origin: .zero, size: size))
            .cgPath
        ctx.cgContext.addPath(path)
        ctx.cgContext.setFillColor(UIColor.black.cgColor)
        ctx.cgContext.fillPath()
    }
    return raw.withRenderingMode(.alwaysTemplate)
}()

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
                    Label {
                        Text("Horses")
                    } icon: {
                        Image(uiImage: horseTabUIImage)
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
