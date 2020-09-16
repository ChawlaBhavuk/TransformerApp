//
//  TransformerModel.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct WelcomeTransformers: Codable {
    let transformers: [Transformer]
}

// MARK: - Transformer
struct Transformer: Codable {
    let courage, endurance, firepower: Int
    let id: String
    let intelligence: Int
    let name: String
    let rank, skill, speed, strength: Int
    let team: String
    let teamIcon: String

    enum CodingKeys: String, CodingKey {
        case courage, endurance, firepower, id, intelligence, name, rank, skill, speed, strength, team
        case teamIcon = "team_icon"
    }
}
