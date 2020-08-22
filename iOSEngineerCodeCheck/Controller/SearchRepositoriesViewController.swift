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

    var repositoriesInfo: [[String: Any]]=[]
    var slectedRepositoryIndex: Int?

    var githubSearchManager = GithubSearchManager()
    var getSelectedRepositoryDetailManager = GetSelectedRepositoryDetailManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repositoriesSearchBar.text = "GitHubのリポジトリを検索できるよー"
        repositoriesSearchBar.delegate = self
        githubSearchManager.delegate = self

        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.detailSegue {
            guard let dtl = segue.destination as? ShowRepositoriesDetailViewController else { return }
            dtl.searchRepositoriesVC = self
        }
    }

    // MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! RepositoryCell
        let repositoryDetail = getSelectedRepositoryDetailManager.getDetail(repositoryDetailArray: repositoriesInfo, selectedIndex: indexPath.row)

        cell.titleLabel.text = repositoryDetail.title
        cell.languageLabel.text = repositoryDetail.language
        cell.starsCountLabel.text = "\(repositoryDetail.starsCount)"
        cell.tag = indexPath.row
        return cell
    }

    // MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        slectedRepositoryIndex = indexPath.row
        performSegue(withIdentifier: K.detailSegue, sender: self)
    }

    // MARK: - UIScrollViewDelegate

    // スクロールしたとき、キーボードが閉じるようにする
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        repositoriesSearchBar.resignFirstResponder()
    }

}

// MARK: - UISearchBar Delegate Methods

extension SearchRepositoriesViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let word = searchBar.text {
            githubSearchManager.fetchRepositories(repoName: word)
        }

        repositoriesSearchBar.resignFirstResponder()
    }

}

// MARK: - GithubSearchManager Delegate Methods

extension SearchRepositoriesViewController: GithubSearchManagerDelegate {

    func didUpdateRepositories(repositories: [[String: Any]]) {
        self.repositoriesInfo = repositories

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }

}
