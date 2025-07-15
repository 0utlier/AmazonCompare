// ContentView.swift 07.12.25
import SwiftUI

struct ContentView: View {
    @State private var product1 = AmazonProduct.empty
    @State private var product2 = AmazonProduct.empty
    @State private var columnWidth: CGFloat = 400  // Starting width for each column

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ComparisonColumnView(product: $product1)
                    .frame(width: columnWidth)
                    .border(Color.gray)

                ResizableDivider(width: $columnWidth)

                ComparisonColumnView(product: $product2)
                    .frame(width: geometry.size.width - columnWidth - 4)  // 4 = divider width
                    .border(Color.gray)
            }
        }
        .frame(minWidth: 700, minHeight: 600)
    }
}
