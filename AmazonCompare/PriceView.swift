// PriceView.swift 07.12.25
import SwiftUI

struct PriceView: View {
    var price: Double
    var compareTo: Double?

    @State private var isHovering = false

    var priceDifferenceText: String {
        guard let other = compareTo else { return "" }
        let diff = price - other
        let sign = diff >= 0 ? "+" : "-"
        return " (\(sign)\(String(format: "%.2f", abs(diff))))"
    }

    var body: some View {
        HStack {
            Text("Price: $\(String(format: "%.2f", price))")
//                .onHover { hovering in
//                    if hovering && !isHovering {
//                        isHovering = true
//                        WebViewLauncher.showWebView(url: URL(string: "https://camelcamelcamel.com")!)
//                    } else if !hovering && isHovering {
//                        isHovering = false
//                        WebViewLauncher.closeWebView()
//                    }
//                }

            if compareTo != nil {
                Text(priceDifferenceText)
                    .foregroundColor(.secondary)
            }
        }
    }
}
    