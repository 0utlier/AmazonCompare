//  URLImage.swift 07.14.25
import SwiftUI

struct URLImage: View {
    let url: URL?
    @State private var loadedImage: Image?

    var body: some View {
        ZStack {
            if let image = loadedImage {
                image
                    .resizable()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(Text("...").font(.caption))
            }
        }
        .onAppear(perform: loadImage)
    }

    private func loadImage() {
        guard let url = url, loadedImage == nil else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let nsImage = NSImage(data: data) {
                DispatchQueue.main.async {
                    self.loadedImage = Image(nsImage: nsImage)
                }
            }
        }.resume()
    }
}
