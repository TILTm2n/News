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
        view.backgroundColor = .green
        view.addSubview(authorLabel)
        view.addSubview(newsImage)
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        
        newsImage.addSubview(myActivityIndicator)
        myActivityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        myActivityIndicator.color = .blue
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.center = newsImage.center
        myActivityIndicator.startAnimating()
        
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
        //let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            guard let url = URL(string: "\(self.article.urlToImage)") else {
//                return
//            }
//            do {
//                let image = try Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    self.newsImage.image = UIImage(data: image)
//                }
//            } catch let error {
//                print("\(error)")
//            }
//        }
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsImage.heightAnchor.constraint(equalToConstant: 200),
            newsImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            newsImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            newsImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
    }
}
