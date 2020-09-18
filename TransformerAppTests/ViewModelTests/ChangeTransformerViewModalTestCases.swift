//
//  ChangeTransformerViewModalTestCases.swift
//  TransformerAppTests
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
import XCTest
@testable import TransformerApp

class ChangeTransformerViewModalTestCases: XCTestCase {
    var viewModel: ChangeTransformerViewModal!

    override func setUp() {
        viewModel = ChangeTransformerViewModal()
    }

    func testCustomTransformer() {
        let tranformer = self.createMockTransformer(team: "A")
        viewModel.setData(transformer: tranformer)
        XCTAssertTrue(viewModel.customTransformer.team == "A")
    }

    func testCheckValue() {
        XCTAssertTrue(viewModel.checkValue(value: "2") == 2)
    }

    func testCheckValidData() {
        XCTAssertFalse(viewModel.checkValidData(val: 22))
    }

    func testErrorMapData() {
        let tranformer = self.createMockTransformer(name: "test", skill: 0, team: "B")
        viewModel.setData(transformer: tranformer)
        XCTAssertNotNil(viewModel.mapAndCheckData().1)
    }

    func testSuccesMapData() {
        let tranformer = self.createMockTransformer(name: "test", skill: 9, team: "B")
        viewModel.setData(transformer: tranformer)
        XCTAssertNotNil(viewModel.mapAndCheckData().0)
    }

    func createMockTransformer(name: String = "Megatron", skill: Int = 3, team: String) -> Transformer {
        let tranformer = Transformer(courage: 2, endurance: 3,
                                     firepower: 6, id: "-MHMhyYqTIbdhVsBculb", intelligence: 8,
                                     name: name, rank: 8, skill: skill, speed: 5,
                                     strength: 9, team: team,
                                     teamIcon: "https://tfwiki.png")
        return tranformer
    }

}
