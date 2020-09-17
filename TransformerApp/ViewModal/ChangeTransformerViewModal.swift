//
//  ChangeTransformerViewModal.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 17/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
import SVProgressHUD

enum Features: String, CaseIterable {
    case name = "Name"
    case strength = "Strength"
    case intelligence = "Intelligence"
    case speed = "Speed"
    case endurance = "Endurance"
    case rank = "Rank"
    case courage = "Courage"
    case firepower = "Firepower"
    case skill = "Skill"

    static func getTitleFor(title: Features) -> String {
        return title.rawValue.localized()
    }
}

class ChangeTransformerViewModal: NSObject {
    var team: Team = .autobots

    var handleData: ((_ value: String?, _ type: Features) -> Void)?
    var transformer = CustomTransformer()
    var networkManager: NetworkRouter = NetworkManager()
    var showAlert: (() -> Void)?
    var showErrorAlert: ((String) -> Void)?
    var showLoader:(() -> Void)?
    var removeLoader:(() -> Void)?
    override init() {
        super.init()
        self.recieveCallbacks()
    }

    /// Assign data according to each field
    func recieveCallbacks() {
        self.handleData = { (value, type) in
            switch type {
            case .strength:
                if let value = value {
                    self.transformer.strength = Int(value)
                } else {
                    self.transformer.strength = nil
                }
            case .intelligence:
                if let value = value {
                    self.transformer.intelligence = Int(value)
                } else {
                    self.transformer.intelligence = nil
                }
            case .speed:
                if let value = value {
                    self.transformer.speed = Int(value)
                } else {
                    self.transformer.speed = nil
                }
            case .endurance:
                if let value = value {
                    self.transformer.endurance = Int(value)
                } else {
                    self.transformer.endurance = nil
                }
            case .rank:
                if let value = value {
                    self.transformer.rank = Int(value)
                } else {
                    self.transformer.rank = nil
                }
            case .courage:
                if let value = value {
                    self.transformer.courage = Int(value)
                } else {
                    self.transformer.courage = nil
                }
            case .firepower:
                if let value = value {
                    self.transformer.firepower = Int(value)
                } else {
                    self.transformer.firepower = nil
                }
            case .skill:
                if let value = value {
                    self.transformer.skill = Int(value)
                } else {
                    self.transformer.skill = nil
                }
            case .name:
                self.transformer.name = value
            }
        }
    }


    /// Send Data to server
    /// - Parameter transformer: CustomTransformer's object
    func sendData(transformer: CustomTransformer) {
        var dict = [String: Any]()
        dict[CustomTransformer.SerializationKeys.courage] = transformer.courage
        dict[CustomTransformer.SerializationKeys.endurance] = transformer.endurance
        dict[CustomTransformer.SerializationKeys.firepower] = transformer.firepower
        dict[CustomTransformer.SerializationKeys.id] = 0
        dict[CustomTransformer.SerializationKeys.intelligence] = transformer.intelligence
        dict[CustomTransformer.SerializationKeys.name] = transformer.name
        dict[CustomTransformer.SerializationKeys.rank] = transformer.rank
        dict[CustomTransformer.SerializationKeys.speed] = transformer.speed
        dict[CustomTransformer.SerializationKeys.strength] = transformer.strength
        dict[CustomTransformer.SerializationKeys.skill] = transformer.skill
        if team == Team.autobots {
            dict[CustomTransformer.SerializationKeys.team] = "A"
        } else if team == Team.decepticons {
            dict[CustomTransformer.SerializationKeys.team] = "D"
        }
        self.showLoader?()
        networkManager.getDataFromApi(type: Transformer.self,
                                      call: .addData, postData: dict) { [weak self] (_, error)  in
            self?.removeLoader?()
            if error != nil {
                self?.showErrorAlert?(AppLocalization.AlertStrings.errorMessage)
            } else {
                self?.showAlert?()
            }
        }
    }
}
