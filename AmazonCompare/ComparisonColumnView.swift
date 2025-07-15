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

                    case .failure(let error):
                        print("Fetch error: \(error.localizedDescription)")
                    }
                }
            }
            

            // Product Title
            Text("Title: \(product.title)")
                .font(.headline)

            // Product Price
            Text(String(format: "Price: $%.2f", product.price))
                .font(.subheadline)

            // Product Rating (newly added)
            if product.rating > 0 {
                Text("Rating: \(String(format: "%.1f", product.rating)) / 5.0")
                    .font(.subheadline)
                    .foregroundColor(.yellow) // You can adjust the color or add stars here
            }

            Spacer()
        }
        .padding()
    }
}

