// ResizableDivider.swift
import SwiftUI

struct ResizableDivider: View {
    @Binding var width: CGFloat
    let minWidth: CGFloat = 200
    let maxWidth: CGFloat = 700

    var body: some View {
        Rectangle()
            .fill(Color.secondary)
            .frame(width: 4)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newWidth = width + value.translation.width
                        if newWidth >= minWidth && newWidth <= maxWidth {
                            width = newWidth
                        }
                    }
            )
            .background(Color.gray.opacity(0.3))
            .edgesIgnoringSafeArea(.vertical)
    }
}
