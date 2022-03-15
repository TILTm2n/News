//
//  NewsViewController.swift
//  NewsPosts
//
//  Created by Eugene on 01.03.2022.
//

import UIKit

enum State: Int {
    case active
    case inactive
}

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pageNumber = 2
    var state: State = .active
    var articles = [Article]()
    var newsTableView = NewsTableView()
    lazy var NewsManager = APINewsManager(key: "00918c3d3188418eb025b1318a41d30c", page: pageNumber)
    
    lazy var refreshControl : UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    lazy var spinner : UIActivityIndicatorView = {
        var spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: 0, y: 0, width: 320, height: 44)
        return spinner
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
    
    func enableInfiniteScrollUI() {
        spinner.startAnimating()
        newsTableView.tableFooterView = spinner
    }

    func disableInfiniteScrollUI() {
        spinner.stopAnimating()
        newsTableView.tableFooterView = nil
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
                //self.articles = news.articles
                self.articles.append(contentsOf: news.articles)
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                    if (self.pageNumber >= 5){
                        self.state = .inactive
                        self.disableInfiniteScrollUI()
                    }
                    if (self.state == .active) {
                        self.pageNumber += 1
                    }
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
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = articles.count - 1
        if (indexPath.row == lastElement && state == .active) {
            enableInfiniteScrollUI()
            getFreshNews()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.configureCell(with: articles[indexPath.row].title ?? "no data", amount: indexPath.row )
        print("\(indexPath.row) ----> \(articles[indexPath.row].title ?? "sosi")")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = NewsDetailViewController(article: articles[indexPath.row])
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
    }
}
