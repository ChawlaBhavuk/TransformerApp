//
//  TransformerListViewModalTestCases.swift
//  TransformerAppTests
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
import XCTest

@testable import TransformerApp

class TransformerListViewModalTestCases: XCTestCase {
    var viewModel: TransformerListViewModal!
    var mockNetworkManager: MockNetworkManager!
    override func setUp() {
        viewModel = TransformerListViewModal()
        mockNetworkManager = MockNetworkManager()
        viewModel?.networkManager = mockNetworkManager

    }

    /// For mocking data
    func testFetchWithSuccessService() {
        self.viewModel.fetchTransformers()
        XCTAssertTrue(self.viewModel.items.count == 1)
    }

    /// test add transformer in autobots
    func testAddTransformerInAutobot() {
        let tranformer = self.createMockTransformer(team: "A")
        XCTAssertTrue(viewModel.selectTransform(transformer: tranformer, team: .autobots).0.count == 1)
    }

    /// test delete transformer in autobots
    func testDeleteTransformerInAutobot() {
        viewModel.autobotsSelectedArray.append(self.createMockTransformer(team: "A"))
        let tranformer = self.createMockTransformer(team: "A")
        XCTAssertTrue(viewModel.selectTransform(transformer: tranformer, team: .autobots).0.count == 0)
    }

    /// test add transformer in decepticons
    func testAddTransformerIndecepticons() {
        let tranformer = self.createMockTransformer(team: "B")
        XCTAssertTrue(viewModel.selectTransform(transformer: tranformer, team: .decepticons).1.count == 1)
    }

    /// test delete transformer in decepticons
    func testDeleteTransformerIndecepticons() {
        viewModel.deceptionsSelectedArray.append(self.createMockTransformer(team: "B"))
        let tranformer = self.createMockTransformer(team: "B")
        XCTAssertTrue(viewModel.selectTransform(transformer: tranformer, team: .decepticons).1.count == 0)
    }

    /// check transformer exist or not
    func testCheckTransformerExistOrNot() {
        let value = viewModel.checkTransformerExist(selected:
            [self.createMockTransformer(team: "B")], transformer: self.createMockTransformer(team: "B"))
        XCTAssertTrue(value)
        let notContain = viewModel.checkTransformerExist(selected:
            [], transformer: self.createMockTransformer(team: "B"))
        XCTAssertFalse(notContain)
    }

    /// delete data then adding data from mock api
    func testDeleteTransformer() {
        viewModel.deleteTransformer(id: "-MHMhyYqTIbdhVsBculb")
        XCTAssertTrue(self.viewModel.items.count == 1)
    }

    /// delete data then adding data from mock api
    func testCreateItems() {
        viewModel.autobotsSelectedArray = [self.createMockTransformer(team: "B")]
        viewModel.deceptionsSelectedArray = [self.createMockTransformer(team: "A")]
        viewModel.items.append(TransformerViewModelDecepticonsItem(transformers:
            viewModel.autobotsSelectedArray))
        viewModel.items.append(TransformerViewModelAutobotsItem(transformers:
            viewModel.autobotsSelectedArray))
        XCTAssertTrue(self.viewModel.items.count == 2)
    }

    func createMockTransformer(team: String) -> Transformer {
        let tranformer = Transformer(courage: 2, endurance: 3,
                                     firepower: 6, id: "-MHMhyYqTIbdhVsBculb", intelligence: 8,
                                     name: "Megatron", rank: 8, skill: 7, speed: 5,
                                     strength: 9, team: team,
                                     teamIcon: "https://tfwiki.png")
        return tranformer
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkManager = nil
    }

}

class MockNetworkManager: NetworkRouter {
    func getDataFromApi<T>(type: T.Type, call: ApiCall, postData: [String: Any]?,
                           completion: @escaping ServiceResponse<T>) where T: Decodable {
        if isError {
            completion(nil, "error")
        } else {
            completion(self.createMockTransformerListData() as? T, nil)
        }
    }

    var isError = false
    var noMoreResults = false

    func createMockTransformerListData() -> WelcomeTransformers {
        let tranformer = Transformer(courage: 2, endurance: 3,
                                     firepower: 6, id: "-MHMhyYqTIbdhVsBculb", intelligence: 8,
                                     name: "Megatron", rank: 8, skill: 7, speed: 5,
                                     strength: 9, team: "A",
                                     teamIcon: "https://tfwiki.png")
        let data =  WelcomeTransformers(transformers: [tranformer])
        return data
    }
}
