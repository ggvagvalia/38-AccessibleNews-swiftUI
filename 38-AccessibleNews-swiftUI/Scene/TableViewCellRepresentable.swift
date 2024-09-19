//
//  TableViewCellRepresentable.swift
//  38-AccessibleNews-swiftUI
//
//  Created by gvantsa gvagvalia on 6/17/24.
//

import UIKit
import SwiftUI

struct TableViewCellRepresentable: UIViewRepresentable {
    @ObservedObject var viewModel: MainPageViewModel
    var didSelectRow: (Articles) -> Void
    
    func makeUIView(context: Context) -> UITableView {
        createTableView()
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.delegate = context.coordinator
        uiView.dataSource = context.coordinator
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

extension TableViewCellRepresentable {
    
    class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSource {
        let parent: TableViewCellRepresentable
        
        init(parent: TableViewCellRepresentable) {
            self.parent = parent
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            parent.viewModel.newsModel.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            let newsData = parent.viewModel.newsModel[indexPath.row]
            let rootView = CustomRowView(news: newsData)
            let hostingController = UIHostingController(rootView: rootView)
//            let hostingController = UIHostingController(rootView: NavigationLink(value: newsData) {
//                CustomRowView(news: newsData)
//            }
//            )
            hostingController.view.backgroundColor = .clear
            hostingController.view.frame = cell.contentView.bounds
            hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.addSubview(hostingController.view)
            
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
            ])
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let selectedArticle = parent.viewModel.newsModel[indexPath.row]
            parent.didSelectRow(selectedArticle)
        }
    }
}
