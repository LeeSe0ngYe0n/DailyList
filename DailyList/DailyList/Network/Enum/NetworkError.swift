import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case encodingError
    case decodingError
}
