//  AmazonFetcher.swift 07.12.25
/* When you're ready to switch from ScraperAPI to something else (like BrightData, Apify, or custom proxy), all you have to do is replace the logic inside AmazonFetcher.swift. */
import Foundation

class AmazonFetcher {
    static let shared = AmazonFetcher()
    private let apiKey = "54e33aa25cab88c383e15a154fb9cfc7"

    func fetchProductData(for url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        var components = URLComponents(string: "https://api.scraperapi.com/")!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "url", value: url.absoluteString),
            URLQueryItem(name: "autoparse", value: "true")
        ]

        guard let finalURL = components.url else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
//                if let raw = String(data: data, encoding: .utf8) {
//                    print("📦 Raw Response from ScraperAPI:\n\(raw)")
//                }

            } else {
                completion(.failure(URLError(.unknown)))
            }
        }.resume()
    }
}
