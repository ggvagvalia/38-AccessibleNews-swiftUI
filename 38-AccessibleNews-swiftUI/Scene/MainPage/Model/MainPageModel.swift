//
//  MainPageModel.swift
//  38-AccessibleNews-swiftUI
//
//  Created by gvantsa gvagvalia on 6/17/24.
//

import Foundation

struct NewsApi: Decodable, Hashable {
    var articles: [Articles]?
}

struct Articles: Decodable, Hashable {
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: String?
    
    func formattedDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: publishedAt ?? "") {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}
