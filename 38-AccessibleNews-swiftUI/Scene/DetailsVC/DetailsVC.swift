//
//  DetailsVC.swift
//  38-AccessibleNews-swiftUI
//
//  Created by gvantsa gvagvalia on 6/17/24.
//

import UIKit
import SwiftUI

class DetailsVC: UIViewController {
    // MARK: - Properties
    let articles: Articles?
    private let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .label
        view.numberOfLines = 0
        view.lineBreakMode = .byTruncatingTail
        return view
    }()
    
    let newsImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let authorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.text = "author = "
        view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return view
    }()
    
    let releaseDate: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    
    // MARK: - lifeCycle
    init(articles: Articles?) {
        self.articles = articles
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func getDetailedInfo() {
        titleLabel.text = articles?.title
        descriptionLabel.text = articles?.description
        authorLabel.text = ("By: \(articles?.author ?? "")")
        releaseDate.text = articles?.formattedDate()
        
        if let imageUrl = URL(string: articles?.urlToImage ?? "") {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        let imageBackground = UIImage(data: data)
                        self.newsImage.image = imageBackground
                    }
                }
            }.resume()
        }
    }
    
    // MARK: - UI
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Details"
        
        getDetailedInfo()
        
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(newsImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(releaseDate)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor),
            
            newsImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            newsImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor, multiplier: 0.6),
            
            descriptionLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor),
            
            releaseDate.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            releaseDate.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor),
            releaseDate.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor),
            releaseDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        scrollView.contentSize = contentView.bounds.size
        
    }
    
}
