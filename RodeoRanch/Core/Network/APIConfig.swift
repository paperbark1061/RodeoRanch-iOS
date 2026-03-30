import Foundation

enum APIConfig {
    /// Switch between demo (Vercel) and production (Railway) here.
    static let baseURL: URL = URL(string: "https://rodeo-ranch.vercel.app")!

    /// Set to true to use local mock data instead of making real network calls.
    /// Useful during UI development when the backend isn't available.
    static let useMockData: Bool = true

    enum Endpoint {
        static let auth       = "/api/auth"
        static let login      = "/api/auth/login"
        static let register   = "/api/auth/register"
        static let me         = "/api/auth/me"
        static let events     = "/api/events"
        static let runs       = "/api/runs"
        static let horses     = "/api/horses"
        static let standings  = "/api/standings"
        static let scores     = "/api/scores"
        static let notifications = "/api/notifications"
        static let entries    = "/api/entries"
    }
}
