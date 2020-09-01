//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ShowRepositoryDetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var openIssuesCountLabel: UILabel!

    var repositoryDetail: [String: Any]?
    private let avatarImageManager = AvatarImageManager()
    private let selectedRepositoryDetailManager = SelectedRepositoryDetailManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detail = repositoryDetail else { return }

        let parsedRepositoryDetail = selectedRepositoryDetailManager.getDetail(repositories: detail)

        titleLabel.text = parsedRepositoryDetail.title
        languageLabel.text = "Written in \(parsedRepositoryDetail.language)"
        starsCountLabel.text = "\(parsedRepositoryDetail.starsCount) stars"
        watchersCountLabel.text = "\(parsedRepositoryDetail.watchersCount) watchers"
        forksCountLabel.text = "\(parsedRepositoryDetail.forksCount) forks"
        openIssuesCountLabel.text = "\(parsedRepositoryDetail.openIssuesCount) open issues"
        avatarImageManager.setImage(with: avatarImageView, urlString: parsedRepositoryDetail.avatarImageUrlString)

        titleLabel.adjustsFontSizeToFitWidth = true
    }

}
