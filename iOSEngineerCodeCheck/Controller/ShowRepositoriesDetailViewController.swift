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

        titleLabel.text = "\(repo[K.parseData.title] as? String ?? "")"
        languageLabel.text = "Written in \(repo[K.parseData.language] as? String ?? "")"
        starCountLabel.text = "\(repo[K.parseData.starsCount] as? Int ?? 0) stars"
        watchCountLabel.text = "\(repo[K.parseData.watchersCount] as? Int ?? 0) watchers"
        forkCountLabel.text = "\(repo[K.parseData.forksCount] as? Int ?? 0) forks"
        openedIssueCountLabel.text = "\(repo[K.parseData.openIssuesCount] as? Int ?? 0) open issues"
        getRepositoriesImageManager.getImage(searchRepositoriesVC: searchRepositoriesVC, showRepositoriesDetailVC: self)

        titleLabel.adjustsFontSizeToFitWidth = true
    }

}
