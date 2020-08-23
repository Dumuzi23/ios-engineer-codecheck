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

    private var repositoriesArray: [[String: Any]]=[]
    private var selectedRepositoryDatail: RepositoryDetailModel?

    private var searchRepositoriesManager = SearchRepositoriesManager()
    private var getSelectedRepositoryDetailManager = GetSelectedRepositoryDetailManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        repositoriesSearchBar.text = "GitHubのリポジトリを検索できるよー"
        repositoriesSearchBar.delegate = self
        searchRepositoriesManager.delegate = self

        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.detailSegue {
            guard let dtl = segue.destination as? ShowRepositoryDetailViewController else { return }
            dtl.repositoryDetail = selectedRepositoryDatail
        }
    }

    // MARK: TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! RepositoryCell
        let repository = repositoriesArray[indexPath.row]

        cell.titleLabel.text = repository[K.parseData.title] as? String ?? ""
        cell.languageLabel.text = repository[K.parseData.language] as? String ?? ""
        cell.starsCountLabel.text = "\(repository[K.parseData.starsCount] as? Int ?? 0)"
        cell.tag = indexPath.row
        return cell
    }

    // MARK: TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        selectedRepositoryDatail = getSelectedRepositoryDetailManager.getDetail(repositories: repositoriesArray, selectedIndex: indexPath.row)

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
        // ↓こうすれば初期のテキストを消せる
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

    func didUpdateRepositories(repositories: [[String: Any]]) {
        self.repositoriesArray = repositories

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }

}
