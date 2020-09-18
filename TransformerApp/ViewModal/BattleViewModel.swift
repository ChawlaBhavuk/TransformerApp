//
//  BattleViewModel.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
class BattleViewModel {
    var autobot: [Transformer]
    var decepticon: [Transformer]
    var battleModel = [BattleModel]()
    var result = ""
    var survivors = [Transformer]()
    // MARK: Callbacks
    var reloadData:(() -> Void)?
    var reloadDataWithEmptyMessage:(() -> Void)?

    init(autobot: [Transformer], decepticon: [Transformer]) {
        self.autobot = autobot
        self.decepticon = decepticon
    }

    /// Find winners between autobot and decepticon
    /// - Parameters:
    ///   - autobot: autobot's object
    ///   - decepticon: decepticon's object
    func transformerBattle(autobot: Transformer, decepticon: Transformer ) {
        /*
         Rule 1: Optimus Prime or Predaking wins his fight automatically
         and if they face each other (or a duplicate of each other),
         the game immediately ends with all competitors destroyed
         */
        if autobot.name == "Optimus Prime" && decepticon.name == "Predaking" {
            let model = BattleModel(winner: .destroyed, winnerDetail: .none,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else if autobot.name == "Optimus Prime" {
            let model = BattleModel(winner: .autobot, winnerDetail: .optimus,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else if decepticon.name == "Predaking" {
            let model = BattleModel(winner: .decepticon, winnerDetail: .predaking,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        }
        /*
         RULE 2: If any fighter is down 4 or more points of courage and 3 or more points of strength
         compared to their opponent, the opponent automatically wins the face-off
         regardless of overall rating
         */
        if autobot.strength - decepticon.strength >= 3 && decepticon.courage - autobot.courage >= 4 {
            let model = BattleModel(winner: .decepticon, winnerDetail: .strong,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else if decepticon.strength - autobot.strength >= 3 && autobot.courage - decepticon.courage >= 4 {
            let model = BattleModel(winner: .autobot, winnerDetail: .strong,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        }
        /*
         RULE 3: if one of the fighters is 3 or more points of skill above their opponent,
         they win the fight regardless of overall rating
         */
        if autobot.skill - decepticon.skill >= 3 {
            let model = BattleModel(winner: .autobot, winnerDetail: .skill,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else if decepticon.skill - autobot.skill >= 3 {
            let model = BattleModel(winner: .decepticon, winnerDetail: .skill,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        }
        /*
         The “overall rating” of a Transformer is the following formula:
         (Strength + Intelligence + Speed + Endurance + Firepower)
         */
        let autobotOverallRating = autobot.strength + autobot.intelligence
            + autobot.speed + autobot.endurance + autobot.firepower
        let decepticonOverallRating = decepticon.strength + decepticon.intelligence
            + decepticon.speed + decepticon.endurance + decepticon.firepower
        /*
         RULE 4: The winner is the Transformer with the highest overall rating and In the event of a tie,
         both Transformers are considered destroyed
         */
        if autobotOverallRating > decepticonOverallRating {
            let model = BattleModel(winner: .autobot, winnerDetail: .overallRating,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else if decepticonOverallRating > autobotOverallRating {
            let model = BattleModel(winner: .decepticon, winnerDetail: .overallRating,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else {
            let model = BattleModel(winner: .destroyed, winnerDetail: .none,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        }
    }

    /// format data to raise battle betwwen autobot and decepticon
    func format() {
        self.autobot = self.sort(transformers: autobot)
        self.decepticon = self.sort(transformers: decepticon)
        if autobot.count != 0 && decepticon.count == 0 {
            survivors = autobot
        } else if autobot.count == 0 && decepticon.count != 0 {
            survivors = decepticon
        } else if autobot.count == decepticon.count {
            _ = autobot.enumerated().map {  (index, _) in
                self.transformerBattle(autobot: autobot[index], decepticon: decepticon[index])
            }
        } else if autobot.count > decepticon.count {
            _ = autobot.enumerated().map {  (index, transformer) in
                if index < decepticon.count {
                    self.transformerBattle(autobot: autobot[index], decepticon: decepticon[index])
                } else {
                    survivors.append(transformer)
                }
            }
        } else if decepticon.count > autobot.count {
            _ = decepticon.enumerated().map {  (index, transformer) in
                if index < autobot.count {
                    self.transformerBattle(autobot: autobot[index], decepticon: decepticon[index])
                } else {
                    survivors.append(transformer)
                }
            }
        }
        self.calculateWinner()
    }

    func calculateWinner() {
        let autobotCount = battleModel.filter { $0.winner == .autobot }
        let deceptionCount = battleModel.filter { $0.winner == .decepticon }
        if autobotCount.count == deceptionCount.count {
            result = AppLocalization.Battle.tieMatch
        } else if autobotCount.count > deceptionCount.count {
            result = AppLocalization.Battle.autobotsWin
        } else if deceptionCount.count > autobotCount.count {
            result = AppLocalization.Battle.decepticonsWin
        }
        if battleModel.count == 0 {
            self.reloadDataWithEmptyMessage?()
        } else {
             self.reloadData?()
        }
    }

    func sort(transformers: [Transformer]) -> [Transformer] {
        return transformers.sorted(by: { (transformer1, transformer2) -> Bool in
            return transformer1.rank < transformer2.rank
        })
    }

}
