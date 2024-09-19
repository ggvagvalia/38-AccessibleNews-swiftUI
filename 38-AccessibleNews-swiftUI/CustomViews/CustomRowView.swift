//
//  CustomRowView.swift
//  38-AccessibleNews-swiftUI
//
//  Created by gvantsa gvagvalia on 6/17/24.
//


import SwiftUI

struct CustomRowView: View {
    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State var news: Articles
    @State var isOn = false
    
    var body: some View {
        VStack(spacing: 10) {
            
            Text(news.title ?? "")
                .font(.system(size: fontSize, weight: .bold))
                .lineLimit(nil)
                .frame(maxWidth: .infinity)
                .environment(\.sizeCategory, sizeCategory)
                .accessibilityLabel(Text("Title of The News: \(news.title ?? "")"))
                .padding(.top, 10)
            
            ImageView(imageJPG: news.urlToImage ?? "")
                .frame(width: screenWidth / 1.1, height: screenHeight / 3.3)
            
            Rectangle()
                .background(.gray.opacity(0.5))
                .frame(height: 5)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
        }
        .accessibilityElement(children: .combine)
        .navigationTitle("News")
    }
    
    
    private var fontSize: CGFloat {
        switch sizeCategory {
        case .extraSmall, .small, .medium:
            return 11
        case .large, .extraLarge, .extraExtraLarge, .extraExtraExtraLarge:
            return 18
        case .accessibilityMedium, .accessibilityLarge, .accessibilityExtraLarge, .accessibilityExtraExtraLarge, .accessibilityExtraExtraExtraLarge:
            return 30
        @unknown default:
            return 15
        }
    }
}

//#Preview {
//    CustomRowView(news: Articles(title: "Title", urlToImage: ""))
//}
