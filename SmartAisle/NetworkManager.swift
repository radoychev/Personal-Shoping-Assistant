import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    let baseURL = "https://mobileapi.jumbo.com/v17"
    let headers = [
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0) Gecko/20100101 Firefox/102.0"
    ]
    
    func searchProducts(query: String, offset: Int = 0, limit: Int = 30, completion: @escaping (Result<[Product], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: "\(baseURL)/search") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query.lowercased()), // Use lowercase for query
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(NetworkError.invalidURLComponents))
            return
        }
        
        var request = URLRequest(url: finalURL)
        request.allHTTPHeaderFields = headers
        
        // Log the request URL for debugging
        print("Request URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            // Log the response data for debugging
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response Data: \(responseString)")
            }
            
            do {
                let productResponse = try JSONDecoder().decode(ProductSearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(productResponse.products.data))
                }
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }.resume()
    }
    
    func getProductDetails(productID: String, completion: @escaping (Result<Product, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/products/\(productID)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                if let rawJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Raw JSON response: \(rawJSON)")
                }
                
                let productResponse = try JSONDecoder().decode(ProductDetailResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(productResponse.product.data))
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(.failure(NetworkError.decodingError(error)))
            }
        }.resume()
    }
}


enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidURLComponents
    case noData
    case invalidResponse
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .invalidURLComponents:
            return "The URL components could not be created."
        case .noData:
            return "No data was returned from the server."
        case .invalidResponse:
            return "The server responded with an invalid status code."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        }
    }
}
