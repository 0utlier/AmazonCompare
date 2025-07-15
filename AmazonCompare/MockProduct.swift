// MockProduct.swift 07.12.25
import Foundation

struct MockProduct {
    var url: String
    var title: String
    var price: Double
    var otherPrice: Double?
    var rating: Double
    var ratingPercentage: String
    var images: [String]

    static let sample1 = MockProduct(
        url: "",
        title: "Item Name Here",
        price: 29.99,
        otherPrice: 49.99,
        rating: 4.6,
        ratingPercentage: "89% (4★ & 5★)",
        images: ["Image1", "Image2", "Image3"]
    )

    static let sample2 = MockProduct(
        url: "",
        title: "Another Item Here",
        price: 49.99,
        otherPrice: 29.99,
        rating: 4.2,
        ratingPercentage: "78% (4★ & 5★)",
        images: ["Image4", "Image5"]
    )
}
