//
//  GetWatchersCountManager.swift
//  iOSEngineerCodeCheck
//
//  Created by Tatsuya Amida on 2020/08/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import Alamofire

class WatchersCountManager {

    private let getwatchersURL = "https://api.github.com/repos"

    func setWatchersCount(label: UILabel, repositoryTitle: String) {
        let urlString = "\(getwatchersURL)/\(repositoryTitle)"

        AF.request(urlString, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let safeData = response.data else { return }
                guard let items = try! JSONSerialization.jsonObject(with: safeData) as? [String: Any] else { return }

                label.text = "\(items["subscribers_count"] as? Int ?? 0) watchers"
            case .failure(let error):
                print(error)
            }
        }
    }

}
