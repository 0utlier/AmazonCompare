// RatingView.swift 07.12.25
import SwiftUI

struct RatingView: View {
    var rating: Double
    var percentage: String

    @State private var showTooltip = false

    var body: some View {
        HStack {
            Text("⭐️ \(rating, specifier: "%.1f")")
            Text("(\(percentage))")
                .foregroundColor(.secondary)
        }
        .onHover { hovering in
            showTooltip = hovering
        }
        .overlay(
            Group {
                if showTooltip {
                    Text("Generated from the text of customer reviews")
                        .font(.caption)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                        .offset(y: -50)
                }
            }
        )
    }
}
