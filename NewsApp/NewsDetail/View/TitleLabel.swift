//
//  TitleLabel.swift
//  NewsPosts
//
//  Created by Eugene on 08.03.2022.
//

import UIKit

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 0
        font = .systemFont(ofSize: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(with title: String) {
        text = "Title: \(title)"
    }
    
}
