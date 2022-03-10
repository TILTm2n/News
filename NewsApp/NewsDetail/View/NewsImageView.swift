//
//  NewsImageView.swift
//  NewsPosts
//
//  Created by Eugene on 08.03.2022.
//

import UIKit

class NewsImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
        //image = UIImage(named: "newsIcon")
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
