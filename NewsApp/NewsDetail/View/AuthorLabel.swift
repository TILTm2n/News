//
//  AuthorLabel.swift
//  NewsPosts
//
//  Created by Eugene on 08.03.2022.
//

import UIKit

class AuthorLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 0
        font = UIFont.systemFont(ofSize: 20)
        translatesAutoresizingMaskIntoConstraints = false
        //adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAuthor(with author: String) {
        text = author
    }
}
