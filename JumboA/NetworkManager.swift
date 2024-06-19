import Foundation

class NetworkManager: ObservableObject {
    @Published var products = [Product]()
    @Published var errorMessage: String?
    @Published var isLoading = false
    private var currentPage = 0
    private let pageSize = 30
    private var lastQuery: String? = nil

    func fetchData(query: String? = nil) {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        var urlComponents = URLComponents(string: "https://mobileapi.jumbo.com/v17/search")!
        urlComponents.queryItems = [
            URLQueryItem(name: "offset", value: "\(currentPage * pageSize)"),
            URLQueryItem(name: "limit", value: "\(pageSize)"),
            URLQueryItem(name: "q", value: query)
        ]

        guard let url = urlComponents.url else {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = "Invalid URL"
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0) Gecko/20100101 Firefox/102.0", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedResponse = try decoder.decode(ProductResponse.self, from: data)
                DispatchQueue.main.async {
                    if self.currentPage == 0 {
                        self.products = decodedResponse.products.data
                    } else {
                        self.products.append(contentsOf: decodedResponse.products.data)
                    }
                    self.currentPage += 1
                    self.lastQuery = query
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    func resetAndFetch(query: String? = nil) {
        currentPage = 0
        products.removeAll()
        fetchData(query: query)
    }
}
