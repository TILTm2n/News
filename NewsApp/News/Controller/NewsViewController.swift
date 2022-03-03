//
//  NewsViewController.swift
//  NewsPosts
//
//  Created by Eugene on 01.03.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    var myView: UIView = {
        var view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(myView)
        
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            myView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            myView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
