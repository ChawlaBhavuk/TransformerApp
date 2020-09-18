//
//  BattleViewModelTestCases.swift
//  TransformerAppTests
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
import XCTest

@testable import TransformerApp

class BattleViewModelTestCases: XCTestCase {
    var viewModel: BattleViewModel!
    override func setUp() {
        viewModel = BattleViewModel(autobot: [self.createMockTransformer(team: "A")],
                                    decepticon: [self.createMockTransformer(team: "B")])
    }

    func createMockTransformer(name: String = "Megatron", skill: Int = 3, team: String) -> Transformer {
        let tranformer = Transformer(courage: 2, endurance: 3,
                                     firepower: 6, id: "-MHMhyYqTIbdhVsBculb", intelligence: 8,
                                     name: name, rank: 8, skill: skill, speed: 5,
                                     strength: 9, team: team,
                                     teamIcon: "https://tfwiki.png")
        return tranformer
    }

    func testBattleForTie() {
        self.viewModel.format()
        XCTAssertTrue(viewModel.battleModel[0].winner == .destroyed)
    }

    func testBattleForOptimusPrime() {
        let autobot = [self.createMockTransformer(name: "Optimus Prime", team: "A")]
        let decepticon = [self.createMockTransformer(team: "B")]
        viewModel = BattleViewModel(autobot: autobot, decepticon: decepticon)
        self.viewModel.format()
        XCTAssertTrue(viewModel.battleModel[0].winner == .autobot)
    }

    func testBattleForPredaking() {
        viewModel.decepticon = [self.createMockTransformer(name: "Predaking", team: "B")]
        viewModel.autobot = [self.createMockTransformer(team: "B")]
        self.viewModel.format()
        XCTAssertTrue(viewModel.battleModel[0].winner == .decepticon)
    }

    func testBattleForSkillDecepticon() {
        viewModel.decepticon = [self.createMockTransformer(skill: 8, team: "B")]
        viewModel.autobot = [self.createMockTransformer(team: "B")]
        self.viewModel.format()
        XCTAssertTrue(viewModel.battleModel[0].winner == .decepticon)
    }

    func testBattleForSkillautobot() {
        viewModel.autobot = [self.createMockTransformer(skill: 8, team: "A")]
        viewModel.decepticon = [self.createMockTransformer(team: "B")]
        self.viewModel.format()
        XCTAssertTrue(viewModel.battleModel[0].winner == .autobot)
    }

    func testBattleForSurvivorAutobot() {
        viewModel.autobot = [self.createMockTransformer(skill: 8, team: "A"),
                             self.createMockTransformer(team: "A")]
        viewModel.decepticon = [self.createMockTransformer(team: "B")]
        self.viewModel.format()
        XCTAssertTrue(viewModel.survivors.count == 1)
    }

    func testBattleForSurvivorDecepticon() {
        viewModel.autobot = [self.createMockTransformer(skill: 8, team: "A")]
        viewModel.decepticon = [self.createMockTransformer(team: "B"),
                                self.createMockTransformer(skill: 8, team: "B")]
        self.viewModel.format()
        XCTAssertTrue(viewModel.survivors.count == 1)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
}
