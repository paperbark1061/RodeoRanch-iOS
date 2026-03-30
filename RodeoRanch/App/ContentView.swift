import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authState: AuthState

    var body: some View {
        Group {
            if authState.isAuthenticated {
                MainTabView()
            } else {
                LoginView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: authState.isAuthenticated)
    }
}
