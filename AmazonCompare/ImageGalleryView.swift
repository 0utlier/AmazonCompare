// ImageGalleryView.swift 07.12.25
import SwiftUI

struct ImageGalleryView: View {
    @State var images: [String]  // The image names
    @State private var selectedImage: ImageItem?  // Use an Identifiable type

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 12) {
                ForEach(images.indices, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        Image(images[index])
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .onTapGesture {
                                selectedImage = ImageItem(id: index, name: images[index])
                            }

                        Button(action: {
                            images.remove(at: index)
                        }) {
                            // Replace with a Text-based button for compatibility with macOS 10.15
                            Text("X")
                                .font(.headline)
                                .foregroundColor(.red)
                                .padding(5)
                                .background(Color.white.opacity(0.7))
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .offset(x: -5, y: 5)
                    }
                }
            }
        }
        .sheet(item: $selectedImage) { selectedImage in
            ImagePreviewWindow(imageName: selectedImage.name, allImages: images)
        }
    }
}

// Define an Identifiable type for images
struct ImageItem: Identifiable {
    var id: Int  // This could be the index or any unique identifier
    var name: String
}
