//  AmazonProduct.swift 07.12.25
import Foundation

struct AmazonProduct {
    var title: String
    var price: Double
    var rating: Double
    var fourStarPercentage: Double
    var fiveStarPercentage: Double
    var imageUrls: [String]


    static let empty = AmazonProduct(
        title: "Item name here",
        price: 0.0,
        rating: 0.0,
        fourStarPercentage: 0.0,
        fiveStarPercentage: 0.0,
//        imageUrls: ["https://m.media-amazon.com/images/I/31-aH0bzOSS.jpg"]
        imageUrls: []
    )
}
