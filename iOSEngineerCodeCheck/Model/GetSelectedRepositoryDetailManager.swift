//
//  GetRepositoryDetail.swift
//  iOSEngineerCodeCheck
//
//  Created by Tatsuya Amida on 2020/08/22.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

class GetSelectedRepositoryDetailManager {

    func getDetail(repositories: [String: Any]) -> RepositoryDetailModel {
        let title = repositories[K.parseData.title] as? String ?? {
            assertionFailure("Stringにキャストできませんでした")
            return ""
            }()

        let language = repositories[K.parseData.language] as? String ?? {
            assertionFailure("Stringにキャストできませんでした")
            return "Unknown"
            }()

        let stars = repositories[K.parseData.starsCount] as? Int ?? {
            assertionFailure("Intにキャストできませんでした")
            return 0
            }()
        let forks = repositories[K.parseData.forksCount] as? Int ?? {
            assertionFailure("Intにキャストできませんでした")
            return 0
            }()

        let openIssue = repositories[K.parseData.openIssuesCount] as? Int ?? {
            assertionFailure("Intにキャストできませんでした")
            return 0
            }()

        // アバター画像の情報は階層が違うので、追加の処理が必要
        guard let owner = repositories["owner"] as? [String: Any] else { fatalError("アバター画像のURLを取得できませんでした") }
        guard let avatarImageUrlString = owner[K.parseData.avatarImage] as? String else { fatalError("アバター画像のURLを取得できませんでした") }

        let selectedRepositoryDetail = RepositoryDetailModel(title: title, language: language, starsCount: stars, forksCount: forks, openIssuesCount: openIssue, avatarImageUrlString: avatarImageUrlString)

        return selectedRepositoryDetail
    }

}
