// ImagePreviewWindow.swift
import SwiftUI

struct ImagePreviewWindow: View {
    var imageName: String
    var allImages: [String]

    @Environment(\.presentationMode) var presentationMode
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack {
            GeometryReader { geometry in
                Image(allImages[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                    .background(Color.black)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        currentIndex = allImages.firstIndex(of: imageName) ?? 0
                    }
            }

            HStack {
                Button(action: previousImage) {
                    Rectangle().fill(Color.clear)
                        .frame(width: 60, height: 200)
                        .contentShape(Rectangle())
                }

                Spacer()

                Button(action: nextImage) {
                    Rectangle().fill(Color.clear)
                        .frame(width: 60, height: 200)
                        .contentShape(Rectangle())
                }
            }
        }
        .background(Color.black)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }

    func previousImage() {
        currentIndex = (currentIndex - 1 + allImages.count) % allImages.count
    }

    func nextImage() {
        currentIndex = (currentIndex + 1) % allImages.count
    }
}
