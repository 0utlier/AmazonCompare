//  WebViewLauncher.swift 07.12.25
import Cocoa
import SwiftUI

class WebViewLauncher {
    private static var window: NSWindow?

    static func showWebView(url: URL, width: CGFloat = 600, height: CGFloat = 500) {
        // Avoid opening multiple windows
        if window != nil { return }

        let hostingView = NSHostingView(rootView: WebViewWindow(url: url))

        let newWindow = NSWindow(
            contentRect: NSRect(x: 100, y: 100, width: width, height: height),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        newWindow.contentView = hostingView
        newWindow.title = "Price History"
        newWindow.makeKeyAndOrderFront(nil)

        window = newWindow
    }

    static func closeWebView() {
        window?.close()
        window = nil
    }
}
