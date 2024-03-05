//
//  WebView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/02/2024.
//

import Foundation
import WebKit
import SwiftUI

// UIKit WebView used to display in-app browser (SwiftUI currently has no support)
struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
