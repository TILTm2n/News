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
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.textAlignment = .justified
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        titleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func titleConstraints() {
        NSLayoutConstraint.activate([
            title.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            title.layoutMarginsGuide.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            title.layoutMarginsGuide.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func configureCell(with title: String) {
        self.title.text = title
    }

}
