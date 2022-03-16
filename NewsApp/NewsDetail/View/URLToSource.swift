//
//  URLToSource.swift
//  NewsPosts
//
//  Created by Eugene on 16.03.2022.
//

import UIKit

class URLToSource: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 0
        font = .systemFont(ofSize: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setURL(with url: String) {
        text = url
    }

}
