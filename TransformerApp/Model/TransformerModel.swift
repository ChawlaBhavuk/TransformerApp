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

// MARK: - CustomTransformer
struct CustomTransformer {
    var courage, endurance, firepower: Int?
    var id: String?
    var intelligence: Int?
    var name: String?
    var rank, skill, speed, strength: Int?
    var team: String?

    struct SerializationKeys {
        static let courage = "courage"
        static let endurance = "endurance"
        static let firepower = "firepower"
        static let id = "id"
        static let intelligence = "intelligence"
        static let name = "name"
        static let rank = "rank"
        static let skill = "skill"
        static let speed = "speed"
        static let strength = "strength"
        static let team = "team"
    }

}

// MARK: - EmptyModel
struct EmptyModel: Codable { }
