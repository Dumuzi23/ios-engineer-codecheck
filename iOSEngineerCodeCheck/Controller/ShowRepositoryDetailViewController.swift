//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import AlamofireImage

class ShowRepositoryDetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var openIssuesCountLabel: UILabel!

    var repositoryDetail: RepositoryDetailModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detail = repositoryDetail else { return }

        titleLabel.text = detail.title
        languageLabel.text = "Written in \(detail.language)"
        starsCountLabel.text = "\(detail.starsCount) stars"
        watchersCountLabel.text = "\(detail.watchersCount) watchers"
        forksCountLabel.text = "\(detail.forksCount) forks"
        openIssuesCountLabel.text = "\(detail.openIssuesCount) open issues"

        if let url = URL(string: detail.avatarImageURL) {
            avatarImageView.af.setImage(withURL: url)
        }

        titleLabel.adjustsFontSizeToFitWidth = true
    }

}
