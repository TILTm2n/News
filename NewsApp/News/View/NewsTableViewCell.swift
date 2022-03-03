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
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 3
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        title.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 10)
        title.center = contentView.center
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }

}
