//
//  UIKitDetailsView.swift
//  38-AccessibleNews-swiftUI
//
//  Created by gvantsa gvagvalia on 6/17/24.
//

import SwiftUI

struct UIKitDetailsView: UIViewControllerRepresentable {
@Binding var news: Articles?
    
    func makeUIViewController(context: Context) -> DetailsVC {
        let uiKitVC = DetailsVC(articles: news)
        return uiKitVC
    }
    
    func updateUIViewController(_ uiViewController: DetailsVC, context: Context) {
    }
}
