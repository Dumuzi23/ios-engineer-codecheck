//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ShowRepositoriesDetailViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var watchCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var openedIssueCountLabel: UILabel!
    
    var searchRepositoriesVC: SearchRepositoriesViewController!
    let getRepositoriesImageManager = GetRepositoriesImageManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let selectedIndex = searchRepositoriesVC.slectedRepositoryIndex else { return }
        let repo = searchRepositoriesVC.repositoriesInfo[selectedIndex]
        
        titleLabel.text = "\(repo["full_name"] as? String ?? "")"
        languageLabel.text = "Written in \(repo["language"] as? String ?? "")"
        starCountLabel.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        watchCountLabel.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        forkCountLabel.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        openedIssueCountLabel.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getRepositoriesImageManager.getImage(searchRepositoriesVC: searchRepositoriesVC, showRepositoriesDetailVC: self)
    }

}
