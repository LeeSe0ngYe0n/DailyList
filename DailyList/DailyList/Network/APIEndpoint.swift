import Foundation

struct UserInfoEndpoint: APIEndpointProtocol {
  let path: String = "/api/auths/users"
  let method: HTTPMethod = .get
}

struct LoginEndpoint: APIEndpointProtocol {
  let path: String = "/api/auths/login"
  let method: HTTPMethod = .post
  let loginData: LoginData
  var body: Data? {
    return try? JSONEncoder().encode(loginData)
  }
}

struct RegisterEndpoint: APIEndpointProtocol {
  let path: String = "/api/auths/register"
  let method: HTTPMethod = .post
  let username: String
  let email: String
  let password: String
  
  var body: Data? {
    let registerData: [String: Any] = [
      "username": username,
      "email": email,
      "password": password
    ]
    return try? JSONSerialization.data(withJSONObject: registerData, options: []) // codable로 변경해서 구현해보기 -> requestDTO 이런식으로 사용해보기
  }
}

struct SelectCategoryEndpoint: APIEndpointProtocol {
  let userId: Int
  let method: HTTPMethod = .get
  var path: String {
    return "/api/categories/\(userId)"
  }
}

struct AddCategoryEndpoint: APIEndpointProtocol {
  let userId: Int
  let categoryName: String
  let icon: String
  let color: String
  let method: HTTPMethod = .post
  var path: String {
    return "/api/categories/\(userId)"
  }
  var body: Data? {
    let addCategoryData: [String: Any] = [
      "name": categoryName,
      "icon": icon,
      "user_id": userId,
      "color": color
    ]
    return try? JSONSerialization.data(withJSONObject: addCategoryData, options: [])
  }
}

struct DetailCategoryTodosEndpoint: APIEndpointProtocol {
  let categoryId: Int
  let userId: Int
  var path: String { return "/api/todos/\(userId)/\(categoryId)" }
  let method: HTTPMethod = .get
}

struct AddTodoEndpoint: APIEndpointProtocol {
  let userId: Int
  let categoryId: Int
  let addTodoData: AddTodoData
  let method: HTTPMethod = .post
  
  var path: String {
    return "/api/todos/\(userId)/\(categoryId)"
  }
  
  var body: Data? {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    do {
      return try encoder.encode(addTodoData)
    } catch {
      print("Error encoding addTodoData: \(error)")
      return nil
    }
  }
}

struct completeTodoEndpoint: APIEndpointProtocol {
  let userId: Int
  let todoId: Int
  var method: HTTPMethod = .patch
  var path: String {
    return "/api/todos/\(userId)/\(todoId)/complete"
  }
}
