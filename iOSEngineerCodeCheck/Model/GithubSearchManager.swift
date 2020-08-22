//
//  GithubSearchManager.swift
//  iOSEngineerCodeCheck
//
//  Created by Tatsuya Amida on 2020/08/18.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import Alamofire

protocol GithubSearchManagerDelegate: class {
    func didUpdateRepositories(repositories: [[String: Any]])
    func didFailWithError(error: Error)
}

class GithubSearchManager {
    private let searchURL = "https://api.github.com/search/repositories?"

    weak var delegate: GithubSearchManagerDelegate?

    func fetchRepositories(repoName: String) {
        let urlString = "\(searchURL)q=\(repoName)"

        performRequest(with: urlString)
    }

    private func performRequest(with urlString: String) {
        AF.request(urlString, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let safeData = response.data else { return }
                guard let obj = try! JSONSerialization.jsonObject(with: safeData) as? [String: Any] else { return }
                guard let items = obj["items"] as? [[String: Any]] else { return }

                self.delegate?.didUpdateRepositories(repositories: items)
                print(items)
            case.failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }

}
