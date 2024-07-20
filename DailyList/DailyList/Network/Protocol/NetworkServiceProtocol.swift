import Foundation

protocol NetworkServiceProtocol {
    func makeURLRequest<T: APIEndpointProtocol>(endpoint: T) async throws -> Data
}
