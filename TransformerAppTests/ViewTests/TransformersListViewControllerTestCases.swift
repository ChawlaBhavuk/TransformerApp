//
//  TransformersListViewControllerTestCases.swift
//  TransformerAppTests
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
import XCTest
@testable import TransformerApp

class TransformersListViewControllerTestCases: XCTestCase {
    var transformerListViewController: TransformersListViewController? =
        (AppDelegate.delegate()?.window?.rootViewController
        as? UINavigationController)?.viewControllers.first
        as? TransformersListViewController

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testTableViewDelegateConformance() {
        XCTAssertTrue(((transformerListViewController?.conforms(to: UITableViewDelegate.self)) != nil))
    }

    func testTableViewDataSourceConformance() {
        XCTAssertTrue(((transformerListViewController?.conforms(to: UITableViewDataSource.self)) != nil))
    }

    func testRequiredElementShouldNotNil() {
        XCTAssertNotNil(transformerListViewController?.navigationItem.title)
    }

    func testPushBattleViewControllerOntoStack() {
        let navigationController = MockNavigationController(rootViewController: transformerListViewController!)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        transformerListViewController?.pushToBattleVC()
        XCTAssertTrue(navigationController.pushedViewController is BattleViewController)
    }

    func testPushChangeViewControllerOntoStack() {
        let navigationController = MockNavigationController(rootViewController: transformerListViewController!)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        transformerListViewController?.pushToAddEditTransformer(transformer: nil)
        XCTAssertTrue(navigationController.pushedViewController is ChangeTransformerViewController)
    }

    override func tearDownWithError() throws {
        transformerListViewController = nil
    }

}

class MockNavigationController: UINavigationController {

    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
}
