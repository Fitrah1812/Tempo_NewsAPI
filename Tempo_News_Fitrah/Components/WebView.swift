//
//  WebView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 14/08/23.
//

import SafariServices
import SwiftUI

struct WebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
