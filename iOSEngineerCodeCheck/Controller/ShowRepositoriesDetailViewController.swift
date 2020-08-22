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

    var repositoryDetail: RepositoryDetailModel?
    private let getRepositoriesImageManager = GetRepositoriesImageManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detail = repositoryDetail else { return }

        titleLabel.text = detail.title
        languageLabel.text = "Written in \(detail.language)"
        starCountLabel.text = "\(detail.starsCount) stars"
        watchCountLabel.text = "\(detail.watchersCount) watchers"
        forkCountLabel.text = "\(detail.forksCount) forks"
        openedIssueCountLabel.text = "\(detail.openIssuesCount) open issues"
        getRepositoriesImageManager.getImage(with: avatarImageView, urlString: detail.avatarImageUrlString)

        titleLabel.adjustsFontSizeToFitWidth = true
    }

}
