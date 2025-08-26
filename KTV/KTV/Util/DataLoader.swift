import Foundation

struct DataLoader {
  private static let session: URLSession = .shared
  
  static func load<T: Decodable>(url: String, for type: T.Type) async throws -> T {
    guard let url = URL(string: url) else {
      throw URLError(.unsupportedURL)
    }
    
    let data = try await Self.session.data(for: .init(url: url)).0
    return try JSONDecoder().decode(T.self, from: data)
  }
  
  static func load<T: Decodable>(json: String, for type: T.Type) throws -> T {
    guard let jsonURL = Bundle.main.url(forResource: json, withExtension: "json")
    else {
      throw JSONError.notFound
    }
    
    let data = try Data(contentsOf: jsonURL)
    let model = try JSONDecoder().decode(T.self, from: data)
    
    return model
  }
}

enum JSONError: Error {
  case notFound
}
