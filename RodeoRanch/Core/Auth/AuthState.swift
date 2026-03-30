import Foundation
import Combine

class AuthState: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let tokenKey = "rr_auth_token"

    init() {
        // Restore session from keychain/UserDefaults on launch
        if let token = UserDefaults.standard.string(forKey: tokenKey) {
            APIService.shared.setAuthToken(token)
            // In a real app: validate token + fetch /me
            // For demo: load mock user
            currentUser = MockData.currentUser
            isAuthenticated = true
        }
    }

    @MainActor
    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        // Demo mode: accept any credentials
        if APIConfig.useMockData {
            try? await Task.sleep(nanoseconds: 800_000_000)
            currentUser = MockData.currentUser
            UserDefaults.standard.set("demo-token", forKey: tokenKey)
            APIService.shared.setAuthToken("demo-token")
            isAuthenticated = true
            isLoading = false
            return
        }

        // Real auth
        do {
            struct LoginBody: Encodable { let email, password: String }
            struct LoginResponse: Decodable { let token: String; let user: User }
            let response: LoginResponse = try await APIService.shared.request(
                endpoint: APIConfig.Endpoint.login,
                method: .post,
                body: LoginBody(email: email, password: password)
            )
            UserDefaults.standard.set(response.token, forKey: tokenKey)
            APIService.shared.setAuthToken(response.token)
            currentUser = response.user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func logout() {
        currentUser = nil
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: tokenKey)
        APIService.shared.setAuthToken(nil)
    }
}
