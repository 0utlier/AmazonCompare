//  AmazonParser.swift
import Foundation

class AmazonParser {

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


}
