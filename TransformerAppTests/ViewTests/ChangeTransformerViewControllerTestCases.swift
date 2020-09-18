//
//  ChangeTransformerViewControllerTestCases.swift
//  TransformerAppTests
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
import XCTest
@testable import TransformerApp

class ChangeTransformerViewControllerTestCases: XCTestCase {
    var changeTransformerViewController: ChangeTransformerViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        changeTransformerViewController = storyboard.instantiateViewController(withIdentifier:
            ChangeTransformerViewController.className) as? ChangeTransformerViewController
        changeTransformerViewController.loadViewIfNeeded()
    }

    func testTableViewDelegateConformance() {
        XCTAssertTrue(changeTransformerViewController.conforms(to: UITableViewDelegate.self))
    }

    func testTableViewDataSourceConformance() {
        XCTAssertTrue(changeTransformerViewController.conforms(to: UITableViewDataSource.self))
    }

    func testRequiredElementShouldNotNil() {
        XCTAssertNotNil(changeTransformerViewController.navigationItem.title)
    }

    override func tearDownWithError() throws {
        changeTransformerViewController = nil
    }
}
