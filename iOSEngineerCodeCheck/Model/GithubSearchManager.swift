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
    let SearchURL = "https://api.github.com/search/repositories?"
    
    weak var delegate: GithubSearchManagerDelegate?
    
    func fetchRepositories(repoName: String) {
        let urlString = "\(SearchURL)q=\(repoName)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        AF.request(urlString, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let safeData = response.data {
                    if let obj = try! JSONSerialization.jsonObject(with: safeData) as? [String: Any] {
                        if let items = obj["items"] as? [[String: Any]] {
                            self.delegate?.didUpdateRepositories(repositories: items)
                            print(items)
                        }
                    }
                }
            case.failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
}
