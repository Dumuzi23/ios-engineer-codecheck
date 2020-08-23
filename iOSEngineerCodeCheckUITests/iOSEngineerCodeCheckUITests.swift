//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

class iOSEngineerCodeCheckUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testSearch() {
        let app = XCUIApplication()
        print(app.debugDescription)

        XCTContext.runActivity(named: "検索ワードの入力") { _ in
            let searchField = app.searchFields.element(boundBy: 0)
            XCTAssert(searchField.exists)
            searchField.tap()
            searchField.typeText("Swift")
        }

        XCTContext.runActivity(named: "検索を行う") { _ in
            let keybord = app.keyboards.element(boundBy: 0)
            XCTAssert(keybord.exists)

            let searchButton = app.buttons["Search"]
            XCTAssert(searchButton.exists)
            searchButton.tap()
        }
        XCTContext.runActivity(named: "検索結果が表示されているか") { _ in
            let firstCell = app.cells.element(boundBy: 0)
            XCTAssert(firstCell.waitForExistence(timeout: 3))

            let firstText = firstCell.children(matching: .staticText).element(boundBy: 0)
            let secondText = firstCell.children(matching: .staticText).element(boundBy: 1)
            let thirdText = firstCell.children(matching: .staticText).element(boundBy: 2)
            XCTAssert(firstText.exists)
            XCTAssert(secondText.exists)
            XCTAssert(thirdText.exists)

            firstCell.tap()
        }

        XCTContext.runActivity(named: "詳細情報が表示されているか") { _  in
            let image = app.images.element(boundBy: 0)
            let title = app.staticTexts.element(boundBy: 1)
            let language = app.staticTexts.element(boundBy: 2)
            let stars = app.staticTexts.element(boundBy: 3)
            let forks = app.staticTexts.element(boundBy: 4)
            let openIssues = app.staticTexts.element(boundBy: 5)

            XCTAssert(image.waitForExistence(timeout: 1))
            XCTAssert(title.waitForExistence(timeout: 1))
            XCTAssert(language.waitForExistence(timeout: 1))
            XCTAssert(stars.waitForExistence(timeout: 1))
            XCTAssert(forks.waitForExistence(timeout: 1))
            XCTAssert(openIssues.waitForExistence(timeout: 1))
        }

    }

}
