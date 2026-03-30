import SwiftUI

@main
struct RodeoRanchApp: App {
    @StateObject private var authState = AuthState()
    @StateObject private var appRouter = AppRouter()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authState)
                .environmentObject(appRouter)
                .preferredColorScheme(.dark)
        }
    }
}
