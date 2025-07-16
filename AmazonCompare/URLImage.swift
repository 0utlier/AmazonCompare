//  URLImage.swift 07.14.25
import SwiftUI

struct URLImage: View {
    let url: URL?
    let placeholder: Image
    var contentMode: ContentMode = .fit
    var height: CGFloat = 100

    @State private var loadedImage: NSImage? = nil

    var body: some View {
        Group {
            if let loadedImage = loadedImage {
                Image(nsImage: loadedImage)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(height: height)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(height: height)
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard loadedImage == nil, let url = url else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let nsImage = NSImage(data: data) {
                DispatchQueue.main.async {
                    self.loadedImage = nsImage
                }
            }
        }.resume()
    }
}
