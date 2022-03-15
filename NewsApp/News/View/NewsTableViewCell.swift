//
//  NewsTableViewCell.swift
//  NewsPosts
//
//  Created by Eugene on 02.03.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsCell"
    
    private var title: UILabel = {
        var title = UILabel()
        title.font = .systemFont(ofSize: 20, weight: .black)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.textAlignment = .justified
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private var amount: UILabel = {
        var amount = UILabel()
        amount.translatesAutoresizingMaskIntoConstraints = false
        return amount
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        contentView.addSubview(amount)
        titleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func titleConstraints() {
        NSLayoutConstraint.activate([
            title.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: amount.leadingAnchor, constant: -30),
            title.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            amount.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            amount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            amount.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func configureCell(with title: String, amount: Int) {
        self.title.text = title
        self.amount.text = "\(amount)"
    }
    

}
