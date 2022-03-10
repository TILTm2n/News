//
//  ContentLabel.swift
//  NewsPosts
//
//  Created by Eugene on 08.03.2022.
//

import UIKit

class ContentLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 0
        font = .systemFont(ofSize: 14)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(with content: String) {
        text = "Content: \(content)"
    }

}
