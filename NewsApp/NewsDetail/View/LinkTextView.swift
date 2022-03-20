//
//  LinkTextView.swift
//  NewsPosts
//
//  Created by Eugene on 19.03.2022.
//

import UIKit

class LinkTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    convenience init() {
        self.init(frame: .zero, textContainer: nil)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .systemFont(ofSize: 30, weight: .bold)
        self.contentInsetAdjustmentBehavior = .automatic
        self.textAlignment = NSTextAlignment.justified
        self.backgroundColor = UIColor.lightGray
        self.isUserInteractionEnabled = true
        self.textColor = UIColor.black
        self.isEditable = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
