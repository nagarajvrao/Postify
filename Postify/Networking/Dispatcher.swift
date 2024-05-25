//
//  Dispatcher.swift
//  Networking
//
//  Created by Nagaraj Rao on 25/05/24.
//

import Foundation
import Combine

public struct NetworkDispatcher {    
    let urlSession: URLSession
    let logger: Logger // Add logger
    
    public init(urlSession: URLSession = .shared, logger: Logger = ConsoleLogger()) {
        self.urlSession = urlSession
        self.logger = logger
    }
    
    /// Dispatches an URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<ReturnType: Codable>(request: URLRequest, identifier: String? = nil) -> AnyPublisher<ReturnType, NetworkRequestError> {
        let defaultIdentifier = request.url?.path ?? "Unknown"
        let finalIdentifier = identifier ?? defaultIdentifier
        
        logger.log("'\(finalIdentifier)' Sending request: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        
        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkRequestError.unknownError
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    throw httpError(httpResponse.statusCode)
                }
                
                return data
            }
            .decode(type: ReturnType.self, decoder: JSONDecoder())
            .mapError { error in
                handleError(error)
            }
            .handleEvents(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    logger.log("[\(finalIdentifier)] Request completed successfully")
                case .failure(let error):
                    logger.log("[\(finalIdentifier)] Request failed with error: \(error)")
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    
    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable NetworkRequestError
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}
