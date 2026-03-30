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
                .tabItem { Label("Horses", image: horseTabImage) }
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

    /// Pre-rendered UIImage of the horse silhouette for use in the tab bar.
    /// Tab items only accept Label/Image — we rasterise the Shape once at the
    /// correct scale so it tints correctly with .template rendering mode.
    private var horseTabImage: Image {
        let size = CGSize(width: 26, height: 26)
        let renderer = UIGraphicsImageRenderer(size: size)
        let uiImage = renderer.image { ctx in
            // Draw the horse path filled in black; the tab bar tints it via .template
            let cgPath = HorseShape()
                .path(in: CGRect(origin: .zero, size: size))
                .cgPath
            ctx.cgContext.addPath(cgPath)
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.fillPath()
        }
        return Image(uiImage: uiImage.withRenderingMode(.alwaysTemplate))
    }
}
