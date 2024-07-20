import Foundation

protocol APIEndpointProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var body: Data? { get }
}

extension APIEndpointProtocol {
   private var baseURL: String {
        return "http://127.0.0.1:5001"
    }
    
    var url: String {
        return baseURL + path
    }
    
    var parameters: [String: Any]? { nil }
    var body: Data? { nil }
}

