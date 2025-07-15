import SwiftUI

struct ComparisonColumnView: View {
    @Binding var product: AmazonProduct
    @State private var urlString: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Paste Amazon URL here", text: $urlString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top)
            
            Button("Load Product Info") {
                guard let url = URL(string: urlString) else { return }
                
                AmazonFetcher.shared.fetchProductData(for: url) { result in
                    switch result {
                    case .success(let data):
                        let parser = AmazonParser()
                        
                        // Parse the title
                        if let parsedTitle = parser.parseTitle(from: data) {
                            DispatchQueue.main.async {
                                product.title = parsedTitle
                            }
                        } else {
                            print("Could not parse title.")
                        }
                        
                        // Parse the price
                        if let parsedPrice = parser.parsePrice(from: data) {
                            DispatchQueue.main.async {
                                product.price = parsedPrice
                            }
                        } else {
                            print("Could not parse price.")
                        }
                        
                        // Parse the rating (added here)
                        if let parsedRating = parser.parseRating(from: data) {
                            DispatchQueue.main.async {
                                product.rating = parsedRating
                            }
                        } else {
                            print("Could not parse rating.")
                        }
                        // Parse 4-star percentage
                        if let fourStar = parser.parseFourStarPercentage(from: data) {
                            DispatchQueue.main.async {
                                product.fourStarPercentage = fourStar
                            }
                        } else {
                            print("Could not 4 star rating.")
                        }

                        // Parse 5-star percentage
                        if let fiveStar = parser.parseFiveStarPercentage(from: data) {
                            DispatchQueue.main.async {
                                product.fiveStarPercentage = fiveStar
                            }
                        } else {
                            print("Could not 4 star rating.")
                        }
                        
                    case .failure(let error):
                        print("Fetch error: \(error.localizedDescription)")
                    }
                    
                }
            }
            
            // Product Title
            Text("\(product.title)")
                .font(.headline)
            
            // Product Price
            Text(String(format: "Price: $%.2f", product.price))
                .font(.subheadline)
            
            let combinedFourFive: Int = (Int(product.fiveStarPercentage)) + (Int(product.fourStarPercentage))
            
            Text("Rating: \(String(format: "%.1f", product.rating))★ (5★:\(Int(product.fiveStarPercentage))%, 4★:\(Int(product.fourStarPercentage))%) Combined: \(combinedFourFive)%")
                .font(.subheadline)
                .foregroundColor(.yellow)
            
            Spacer()
        }
        .padding()
    }
}

