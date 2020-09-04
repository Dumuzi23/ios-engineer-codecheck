//
//  RepositoryData.swift
//  iOSEngineerCodeCheck
//
//  Created by Tatsuya Amida on 2020/09/04.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

struct RepositoryData: Codable {
    let items: [Items]
}

struct Items: Codable {
    let full_name: String?
    let owner: Owner?
    let stargazers_count: Int?
    let watchers_count: Int?
    let language: String?
    let forks_count: Int?
    let open_issues: Int?
}

struct Owner: Codable {
    let avatar_url: String?
}
