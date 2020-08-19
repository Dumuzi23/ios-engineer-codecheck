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
        guard let selectedIndex = searchRepositoriesVC.idx else { return }
        let repo = searchRepositoriesVC.repo[selectedIndex]
        
        if let owner = repo["owner"] as? [String: Any] {
            if let imageURL = owner["avatar_url"] as? String {
                if let url = URL(string: imageURL) {
                    showRepositoriesDetailVC.ImgView.af.setImage(withURL: url)
                }
            }
        }
    }
    
}
