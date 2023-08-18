//
//  ActivityIndicatorView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 14/08/23.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    let color: UIColor

    func makeUIView(context: Context) -> UIStackView {
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        activityIndicatorView.color = color
        activityIndicatorView.startAnimating()
        return UIStackView(arrangedSubviews: [activityIndicatorView])
    }

    func updateUIView(_ uiView: UIStackView, context: Context) {}
}
