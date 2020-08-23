//
//  iOSEngineerCodeCheckTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class iOSEngineerCodeCheckTests: XCTestCase {

    let getSelectedRepositoryDetailManager = GetSelectedRepositoryDetailManager()

    let repositoriesForSuccess = [[K.parseData.title: "sampleRepo", K.parseData.language: "Japanese", K.parseData.starsCount: 1, K.parseData.forksCount: 2, K.parseData.openIssuesCount: 3, "owner": [K.parseData.avatarImage: "abcde"]], ["a": "b"]]

    func testGetSelectedRepositoryDetailManager() {
        let selectedRepositoryDetail = getSelectedRepositoryDetailManager.getDetail(repositories: repositoriesForSuccess, selectedIndex: 0)

        XCTContext.runActivity(named: "GetSelectedRepositoryDetailManagerのgetDetailメソッドがRepositoryDetailModelを正確に返すか検証") { _ in
            XCTAssertEqual(selectedRepositoryDetail.title, "sampleRepo")
            XCTAssertEqual(selectedRepositoryDetail.language, "Japanese")
            XCTAssertEqual(selectedRepositoryDetail.starsCount, 1)
            XCTAssertEqual(selectedRepositoryDetail.forksCount, 2)
            XCTAssertEqual(selectedRepositoryDetail.openIssuesCount, 3)
            XCTAssertEqual(selectedRepositoryDetail.avatarImageUrlString, "abcde")
        }
    }

}
