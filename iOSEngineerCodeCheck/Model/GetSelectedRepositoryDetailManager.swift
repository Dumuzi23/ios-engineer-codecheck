//
//  GetRepositoryDetail.swift
//  iOSEngineerCodeCheck
//
//  Created by Tatsuya Amida on 2020/08/22.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

class GetSelectedRepositoryDetailManager {

    func getDetail(repositoryDetailArray: [[String: Any]], selectedIndex: Int) -> RepositoryDetailModel {
        let title = repositoryDetailArray[selectedIndex][K.parseData.title] as? String ?? ""
        let language = repositoryDetailArray[selectedIndex][K.parseData.language] as? String ?? ""
        let stars = repositoryDetailArray[selectedIndex][K.parseData.starsCount] as? Int ?? 0
        let watchers = repositoryDetailArray[selectedIndex][K.parseData.watchersCount] as? Int ?? 0
        let forks = repositoryDetailArray[selectedIndex][K.parseData.forksCount] as? Int ?? 0
        let openIssue = repositoryDetailArray[selectedIndex][K.parseData.forksCount] as? Int ?? 0

        // アバター画像の情報だけは階層が違うので、追加の処理が必要
        guard let owner = repositoryDetailArray[selectedIndex]["owner"] as? [String: Any] else { fatalError("failed get avatarImageURL.") }
        guard let avatarImageUrlString = owner[K.parseData.avatarImage] as? String else { fatalError("failed get avatarImageURL.") }

        let selectedRepositoryDetail = RepositoryDetailModel(title: title, language: language, starsCount: stars, watchersCount: watchers, forksCount: forks, openIssuesCount: openIssue, avatarImageUrlString: avatarImageUrlString)

        return selectedRepositoryDetail
    }

}
