//
//  SurvivorViewControllerTestCases.swift
//  TransformerAppTests
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
import XCTest
@testable import TransformerApp

class SurvivorViewControllerTestCases: XCTestCase {
    var survivorViewController: SurvivorViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        survivorViewController = storyboard.instantiateViewController(withIdentifier:
            SurvivorViewController.className) as? SurvivorViewController
        survivorViewController.loadViewIfNeeded()
    }

    func testTableViewDelegateConformance() {
        XCTAssertTrue(survivorViewController.conforms(to: UITableViewDelegate.self))
    }

    func testTableViewDataSourceConformance() {
        XCTAssertTrue(survivorViewController.conforms(to: UITableViewDataSource.self))
    }

    func testRequiredElementShouldNotNil() {
        XCTAssertNotNil(survivorViewController.navigationItem.title)
    }

    override func tearDownWithError() throws {
        survivorViewController = nil
    }
}
