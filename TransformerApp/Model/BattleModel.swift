//
//  BattleModel.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation

struct BattleModel {
    let winner: ResultEnum
    let winnerDetail: TranformerWinnerRule
    let autobot: Transformer
    let deception: Transformer
}

enum ResultEnum {
    case none
    case autobot
    case decepticon
    case destroyed
}

enum TranformerWinnerRule: String {
    case none = "None"
    case optimus = "Optimus wins"
    case predaking = "Predaking wins"
    case strong = "Stronger"
    case skill = "Skill points"
    case overallRating = "Overall rating"
}
