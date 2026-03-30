import Foundation

class APIService {
    static let shared = APIService()
    private let session = URLSession.shared
    private var authToken: String?

    private init() {}

    func setAuthToken(_ token: String?) {
        self.authToken = token
    }

    // MARK: - Generic request

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        body: Encodable? = nil
    ) async throws -> T {
        let url = APIConfig.baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = authToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body = body {
            request.httpBody = try JSONEncoder.iso8601.encode(body)
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.httpError(httpResponse.statusCode)
        }

        return try JSONDecoder.iso8601.decode(T.self, from: data)
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: LocalizedError {
    case invalidResponse
    case httpError(Int)
    case decodingError
    case unauthorized
    case notFound

    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Invalid server response"
        case .httpError(let code): return "Server error (\(code))"
        case .decodingError: return "Couldn\'t parse server data"
        case .unauthorized: return "Not authenticated"
        case .notFound: return "Not found"
        }
    }
}

// MARK: - JSONEncoder / Decoder helpers

extension JSONEncoder {
    static let iso8601: JSONEncoder = {
        let e = JSONEncoder()
        e.dateEncodingStrategy = .iso8601
        e.keyEncodingStrategy = .convertToSnakeCase
        return e
    }()
}

extension JSONDecoder {
    static let iso8601: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
}
