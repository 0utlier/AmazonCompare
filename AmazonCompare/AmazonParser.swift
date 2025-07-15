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
            // Try to parse JSON data
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // Look for the rating in the JSON data structure
                if let ratingValue = json["rating"] as? Double {
                    return ratingValue
                }
            }
            
            // If not found, return nil
            return nil
        }
    }

