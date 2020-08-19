//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoriesViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var repositoriesSearchBar: UISearchBar!
    
    var repositoriesInfo: [[String: Any]]=[]
    var slectedRepositoryIndex: Int!
    
    var githubSearchManager = GithubSearchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repositoriesSearchBar.text = "GitHubのリポジトリを検索できるよー"
        repositoriesSearchBar.delegate = self
        githubSearchManager.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let word = searchBar.text {
            githubSearchManager.fetchRepositories(repoName: word)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            let dtl = segue.destination as! ShowRepositoriesDetailViewController
            dtl.searchRepositoriesVC = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repositoriesInfo[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        slectedRepositoryIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
}

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
