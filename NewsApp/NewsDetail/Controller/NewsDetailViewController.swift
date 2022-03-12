//
//  NewsDetailViewController.swift
//  NewsPosts
//
//  Created by Eugene on 07.03.2022.
//

import UIKit

class NewsDetailViewController: UIViewController {

    var article: Article
    var newsImage = NewsImageView()
    var authorLabel = AuthorLabel()
    var titleLabel = TitleLabel()
    var contentLabel = ContentLabel()
    
    let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        view.backgroundColor = .green
        view.addSubview(newsImage)
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(contentLabel)
        
        newsImage.addSubview(myActivityIndicator)
        myActivityIndicator.color = .blue
        myActivityIndicator.startAnimating()
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.frame = CGRect(x: newsImage.frame.size.width/2, y: newsImage.frame.size.height/2, width: 100, height: 100)
        
        updateUI()
        setConstraints()
    }
    
    func updateUI() {
        self.authorLabel.setAuthor(with: article.author ?? "")
        self.titleLabel.setTitle(with: article.title ?? "")
        self.contentLabel.setContent(with: article.content ?? "")
        fetchImage()
    }
    
    func fetchImage() {
        
        guard let path = article.urlToImage, let url = URL(string: path) else {
            return
        }
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.newsImage.image = image
                        self?.myActivityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            authorLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            contentLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            contentLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            myActivityIndicator.centerXAnchor.constraint(equalTo: newsImage.centerXAnchor),
            myActivityIndicator.centerYAnchor.constraint(equalTo: newsImage.centerYAnchor),
        ])
    }
}
