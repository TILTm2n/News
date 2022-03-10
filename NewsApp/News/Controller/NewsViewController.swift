//
//  NewsViewController.swift
//  NewsPosts
//
//  Created by Eugene on 01.03.2022.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newsTableView = NewsTableView()
    var NewsData: News?
    lazy var NewsManager = APINewsManager()
    
    lazy var refreshControl : UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(newsTableView)
        newsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadAllDataByRefresh), for: .primaryActionTriggered)
        getFreshNews()
        configureNewsTable()
    }
    
    func configureNewsTable() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        view.addSubview(newsTableView)
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            newsTableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            newsTableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func toggleActivityIndicator(on: Bool) {
        DispatchQueue.main.async {
            self.refreshControl.isHidden = on
            if on {
                self.refreshControl.beginRefreshing()
            } else {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func reloadAllDataByRefresh() {
        toggleActivityIndicator(on: true)
        getFreshNews()
    }
    
    func getFreshNews() {
        NewsManager.FetchFreshNews { result in
            self.toggleActivityIndicator(on: false)
            switch result {
            case .Success(let news):
                self.NewsData = news
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            case.Failure(let error as NSError):
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Unable to get data", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(ok)
                    self.present(alertController, animated: true, completion: nil)
                }
            default: break
            }
        }
    }
}

extension NewsViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        guard let news = NewsData else {
            return cell
        }

        cell.configureCell(with: news.articles[indexPath.row].title ?? "no data" )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let news = NewsData else {
            return
        }
        let vc = NewsDetailViewController(article: news.articles[indexPath.row])
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
    }
}
