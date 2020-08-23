//
//  GetRepositoryDetail.swift
//  iOSEngineerCodeCheck
//
//  Created by Tatsuya Amida on 2020/08/22.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

class GetSelectedRepositoryDetailManager {

    func getDetail(repositories: [[String: Any]], selectedIndex: Int) -> RepositoryDetailModel {
        let title = repositories[selectedIndex][K.parseData.title] as? String ?? ""
        let language = repositories[selectedIndex][K.parseData.language] as? String ?? ""
        let stars = repositories[selectedIndex][K.parseData.starsCount] as? Int ?? 0
        let forks = repositories[selectedIndex][K.parseData.forksCount] as? Int ?? 0
        let openIssue = repositories[selectedIndex][K.parseData.openIssuesCount] as? Int ?? 0

        // アバター画像の情報は階層が違うので、追加の処理が必要
        guard let owner = repositories[selectedIndex]["owner"] as? [String: Any] else { fatalError("failed get avatarImageURL.") }
        guard let avatarImageUrlString = owner[K.parseData.avatarImage] as? String else { fatalError("failed get avatarImageURL.") }

        let selectedRepositoryDetail = RepositoryDetailModel(title: title, language: language, starsCount: stars, forksCount: forks, openIssuesCount: openIssue, avatarImageUrlString: avatarImageUrlString)

        return selectedRepositoryDetail
    }

}
