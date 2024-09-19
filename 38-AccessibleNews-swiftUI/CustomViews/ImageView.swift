//
//  ImageView.swift
//  38-AccessibleNews-swiftUI
//
//  Created by gvantsa gvagvalia on 6/17/24.
//

import SwiftUI

struct ImageView: View {
    let imageJPG: String
    
    var body: some View {
        if let imageURL = URL(string: "\(imageJPG)") {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
            } placeholder: {
                ProgressView()
            }
        } else {
            Text("no image in URL")
        }
    }
    
}
