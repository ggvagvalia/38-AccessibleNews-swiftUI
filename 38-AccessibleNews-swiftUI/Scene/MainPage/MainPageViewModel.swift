//
//  MainPageViewModel.swift
//  38-AccessibleNews-swiftUI
//
//  Created by gvantsa gvagvalia on 6/17/24.
//

import Foundation
import NetworkingNew

class MainPageViewModel: ObservableObject {
    let url = "https://newsapi.org/v2/everything?q=apple&from=2024-06-15&to=2024-06-15&sortBy=popularity&apiKey=fbb62aadf9524551ad626c26160c6331"
    let networking = NetworkingNew.shared
    @Published var newsModel: [Articles] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        networking.fetchData(urlString: url) { (result: Result<NewsApi, Error>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async { [weak self] in
                    self?.newsModel = success.articles ?? []
                }
            case .failure(let failure):
                print("error fetching data \(failure)")
            }
        }
    }
}

