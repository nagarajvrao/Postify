import Foundation

// The Request Method
public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
    
    var message: String {
        switch self {
        case .invalidRequest:
            return "Invalid request."
        case .badRequest:
            return "Bad request."
        case .unauthorized:
            return "Unauthorized."
        case .forbidden:
            return "Forbidden."
        case .notFound:
            return "Resource not found."
        case .error4xx(let code):
            return "Client error: \(code)."
        case .serverError:
            return "Internal server error."
        case .error5xx(let code):
            return "Server error: \(code)."
        case .decodingError:
            return "Decoding error."
        case .urlSessionFailed(let error):
            return "URL session failed with error: \(error.localizedDescription)."
        case .unknownError:
            return "Unknown error occurred."
        }
    }
}
