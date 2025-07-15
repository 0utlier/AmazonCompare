//  AmazonParser.swift
import Foundation

class AmazonParser {

    static let shared = AmazonParser()

    func parseTitle(from data: Data) -> String? {
        do {
            struct ParsedResponse: Decodable {
                let name: String?
            }
            let decoded = try JSONDecoder().decode(ParsedResponse.self, from: data)
            return decoded.name
        } catch {
            print("JSON parse error (title): \(error)")
            return nil
        }
    }

    func parsePrice(from data: Data) -> Double? {
        guard let text = String(data: data, encoding: .utf8) else {
            print("Could not decode data into text")
            return nil
        }

        // Regex pattern to find: "pricing":"$9.99"
        let pattern = #""pricing"\s*:\s*"\$([0-9,.]+)""#
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(text.startIndex..., in: text)

            if let match = regex.firstMatch(in: text, options: [], range: range),
               let priceRange = Range(match.range(at: 1), in: text) {
                let priceString = String(text[priceRange])
                    .replacingOccurrences(of: ",", with: "")
                
                return Double(priceString)
            } else {
                print("Price not found via regex")
            }
        } catch {
            print("Regex error: \(error)")
        }

        return nil
    }
    
    func parseRating(from data: Data) -> Double? {
        struct ParsedResponse: Decodable {
            let averageRating: Double?

            private enum CodingKeys: String, CodingKey {
                case averageRating = "average_rating"
            }
        }

        do {
            let decoded = try JSONDecoder().decode(ParsedResponse.self, from: data)
            return decoded.averageRating
        } catch {
            print("JSON parse error (rating): \(error)")
            return nil
        }
    }

    
    func parseFourStarPercentage(from data: Data) -> Double? {
        struct ParsedResponse: Decodable {
            let fourStar: Double?

            private enum CodingKeys: String, CodingKey {
                case fourStar = "4_star_percentage"
            }
        }

        do {
            let decoded = try JSONDecoder().decode(ParsedResponse.self, from: data)
            return decoded.fourStar
        } catch {
            print("JSON parse error (4-star): \(error)")
            return nil
        }
    }


    func parseFiveStarPercentage(from data: Data) -> Double? {
        struct ParsedResponse: Decodable {
            let fiveStar: Double?

            private enum CodingKeys: String, CodingKey {
                case fiveStar = "5_star_percentage"
            }
        }

        do {
            let decoded = try JSONDecoder().decode(ParsedResponse.self, from: data)
            return decoded.fiveStar
        } catch {
            print("JSON parse error (5-star): \(error)")
            return nil
        }
    }
    
    func parseImageURLs(from data: Data) -> [String]? {
        struct ParsedResponse: Decodable {
            let images: [String]?
        }

        do {
            let decoded = try JSONDecoder().decode(ParsedResponse.self, from: data)
//            print("IMAGES decoded: \(decoded)")
            return decoded.images ?? []
        } catch {
            print("JSON parse error (images): \(error)")
            return []
        }
    }
//}
// ==============================================

func loadAmazonProduct(from amazonURL: String, completion: @escaping (AmazonProduct?) -> Void) {
    guard let encodedProductURL = amazonURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        completion(nil)
        return
    }

    let apiKey = "54e33aa25cab88c383e15a154fb9cfc7"
    let scraperAPIURL = "https://api.scraperapi.com/?api_key=\(apiKey)&url=\(encodedProductURL)&render=false"

    guard let requestURL = URL(string: scraperAPIURL) else {
        completion(nil)
        return
    }

    URLSession.shared.dataTask(with: requestURL) { data, response, error in
        if let error = error {
            print("Network error: \(error.localizedDescription)")
            completion(nil)
            return
        }

        guard let data = data, let _ = String(data: data, encoding: .utf8) else {
            print("Failed to decode HTML")
            completion(nil)
            return
        }

        let title = self.parseTitle(from: data)
        let price = self.parsePrice(from: data)
        let imageUrls = self.parseImageURLs(from: data)
        let rating = self.parseRating(from: data)
        let fourStarPercentage = self.parseFourStarPercentage(from: data)
        let fiveStarPercentage = self.parseFiveStarPercentage(from: data)

        DispatchQueue.main.async {
            let product = AmazonProduct(title: title ?? "text here",
                                        price: price ?? 0.0,
                                        rating: rating ?? 0.0,
                                        fourStarPercentage: fourStarPercentage ?? 0.0,
                                        fiveStarPercentage: fiveStarPercentage ?? 0.0,
                                        imageUrls: imageUrls!)
            completion(product)
        }
    }.resume()


// Helpers
//func extractTitle(from html: String) -> String? {
//    return html.firstMatch(for: #"<span id="productTitle"[^>]*>(.*?)</span>"#)
//}
//
//func extractPrice(from html: String) -> String? {
//    return html.firstMatch(for: #"<span class="a-price[^>]*>\s*<span[^>]*>(\$[0-9.,]+)"#)
//}
//
//func extractImageURLs(from html: String) -> [String]? {
//    let pattern = #"\"hiRes\"\s*:\s*\"(https:[^\"]+)\""#
//    return html.allMatches(for: pattern)
//}
//
//extension String {
//    func firstMatch(for pattern: String) -> String? {
//        if let range = self.range(of: pattern, options: .regularExpression) {
//            return String(self[range])
//                .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
//                .trimmingCharacters(in: .whitespacesAndNewlines)
//        }
//        return nil
//    }
//
//    func allMatches(for pattern: String) -> [String] {
//        do {
//            let regex = try NSRegularExpression(pattern: pattern)
//            let nsrange = NSRange(self.startIndex..<self.endIndex, in: self)
//            let matches = regex.matches(in: self, options: [], range: nsrange)
//            return matches.compactMap {
//                guard let range = Range($0.range(at: 1), in: self) else { return nil }
//                return String(self[range])
//            }
//        } catch {
//            print("Regex error: \(error)")
//            return []
//        }
//    }
//}

}
}
