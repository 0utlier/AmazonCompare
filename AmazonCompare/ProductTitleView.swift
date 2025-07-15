// ProductTitleView.swift 07.12.25
import SwiftUI

struct ProductTitleView: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
    }
}
