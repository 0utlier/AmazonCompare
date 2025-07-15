//  WebViewWindow.swift 07.12.25
import SwiftUI
import WebKit

struct WebViewWindow: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        // No need to update here
    }
}
