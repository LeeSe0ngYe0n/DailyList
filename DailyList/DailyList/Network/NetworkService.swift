import Foundation

final class NetworkService: NetworkServiceProtocol {
  static let shared = NetworkService()
  private init() {}
  
  @discardableResult
  func makeURLRequest<T: APIEndpointProtocol>(endpoint: T) async throws -> Data {
    guard var urlComponents = URLComponents(string: endpoint.url) else {
      throw NetworkError.invalidURL
    }
    
    if let parameters = endpoint.parameters {
      urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
    }
    
    guard let url = urlComponents.url else {
      throw NetworkError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    if let body = endpoint.body {
      request.httpBody = body
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
      throw NetworkError.invalidResponse
    }
    
    return data
  }
}
