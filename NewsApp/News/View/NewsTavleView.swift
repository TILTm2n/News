//
//  NewsTavleView.swift
//  NewsPosts
//
//  Created by Eugene on 07.03.2022.
//

import UIKit

class NewsTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        estimatedRowHeight = 100
        refreshControl = refreshControl
        rowHeight = UITableView.automaticDimension
        translatesAutoresizingMaskIntoConstraints = false
        register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
