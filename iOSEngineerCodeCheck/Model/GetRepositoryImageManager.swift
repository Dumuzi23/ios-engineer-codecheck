//
//  GetRepositoryImageManager.swift
//  iOSEngineerCodeCheck
//
//  Created by Tatsuya Amida on 2020/08/18.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import AlamofireImage

class GetRepositoriesImageManager {

    func getImage(searchRepositoriesVC: SearchRepositoriesViewController, showRepositoriesDetailVC: ShowRepositoriesDetailViewController) {
        guard let selectedIndex = searchRepositoriesVC.slectedRepositoryIndex else { return }
        let repo = searchRepositoriesVC.repositoriesInfo[selectedIndex]

        guard let owner = repo["owner"] as? [String: Any] else { return }
        guard let imageURL = owner["avatar_url"] as? String else { return }
        guard let url = URL(string: imageURL) else { return }

        showRepositoriesDetailVC.avatarImageView.af.setImage(withURL: url)
    }

}
