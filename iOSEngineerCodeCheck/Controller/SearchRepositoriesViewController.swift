//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoriesViewController: UITableViewController {

    @IBOutlet weak var repositoriesSearchBar: UISearchBar!

    private var repositoriesDetailArray: [RepositoryDetailModel] = []
    private var searchRepositoriesManager = SearchRepositoriesManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        repositoriesSearchBar.delegate = self
        searchRepositoriesManager.delegate = self

        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.detailSegue {
            guard let nextVC = segue.destination as? ShowRepositoryDetailViewController else { return }
            if let selectedRow = tableView.indexPathForSelectedRow {
                let repositoryDetail = repositoriesDetailArray[selectedRow[1]]
                nextVC.repositoryDetail = repositoryDetail
            }
        }
    }

    // MARK: TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesDetailArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! RepositoryCell

        cell.titleLabel.text = repositoriesDetailArray[indexPath.row].title
        cell.languageLabel.text = repositoriesDetailArray[indexPath.row].language
        cell.starsCountLabel.text = "\(repositoriesDetailArray[indexPath.row].starsCount)"
        cell.tag = indexPath.row
        return cell
    }

    // MARK: TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.detailSegue, sender: self)
    }

    // MARK: UIScrollViewDelegate
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // スクロールしたとき、キーボードが閉じるようにする
        repositoriesSearchBar.resignFirstResponder()
    }

}

// MARK: - UISearchBar Delegate Methods
extension SearchRepositoriesViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let word = searchBar.text {
            searchRepositoriesManager.fetchRepositories(repoName: word)
        }
        // 検索後はキーボードが閉じるようにする
        repositoriesSearchBar.resignFirstResponder()
    }

}

// MARK: - GithubSearchManager Delegate Methods
extension SearchRepositoriesViewController: SearchRepositoriesManagerDelegate {

    func didUpdateRepositories(repositoriesDetail: [RepositoryDetailModel]) {
        self.repositoriesDetailArray = repositoriesDetail
        self.tableView.reloadData()
    }

    func didFailWithError(error: Error) {
        print(error)
    }

}
