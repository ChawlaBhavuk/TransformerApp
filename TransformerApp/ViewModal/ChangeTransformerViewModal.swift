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

    // MARK: Callbacks
    var handleData: ((_ value: String?, _ type: Features) -> Void)?
    var showAlert: (() -> Void)?
    var showErrorAlert: ((String, Bool) -> Void)?
    var showLoader:(() -> Void)?
    var removeLoader:(() -> Void)?
    var changeTeam:((_ team: Team) -> Void)?

    // MARK: Other Members
    var operation: Operation = .add
    var customTransformer = CustomTransformer()
    var networkManager: NetworkRouter = NetworkManager()
    var team: Team = .autobots
    override init() {
        super.init()
        self.recieveCallbacks()
    }

    enum Operation {
        case add
        case edit
    }

    func setData(transformer: Transformer) {
        operation = .edit
        customTransformer.strength = transformer.strength
        customTransformer.intelligence = transformer.intelligence
        customTransformer.speed = transformer.speed
        customTransformer.endurance = transformer.endurance
        customTransformer.rank = transformer.rank
        customTransformer.courage = transformer.courage
        customTransformer.firepower = transformer.firepower
        customTransformer.skill = transformer.skill
        customTransformer.name = transformer.name
        customTransformer.id = transformer.id
        customTransformer.team = transformer.team
        if let team = customTransformer.team {
            if team == "D" {
                self.team = .decepticons
                self.changeTeam?(.decepticons)
            }
            if team == "A" {
                self.team = .autobots
                self.changeTeam?(.autobots)
            }
        }
    }

    /// Assign data according to each field
    func recieveCallbacks() {
        self.handleData = { (value, type) in
            switch type {
            case .strength:
                self.customTransformer.strength = self.checkValue(value: value)
            case .intelligence:
                self.customTransformer.intelligence = self.checkValue(value: value)
            case .speed:
                self.customTransformer.speed = self.checkValue(value: value)
            case .endurance:
                self.customTransformer.endurance = self.checkValue(value: value)
            case .rank:
                self.customTransformer.rank = self.checkValue(value: value)
            case .courage:
                self.customTransformer.courage = self.checkValue(value: value)
            case .firepower:
                self.customTransformer.firepower = self.checkValue(value: value)
            case .skill:
                self.customTransformer.skill = self.checkValue(value: value)
            case .name:
                self.customTransformer.name = value
            }
        }
    }

    func checkValue(value: String?) -> Int? {
        if let value = value {
            return Int(value)
        } else {
            return nil
        }
    }

    func checkValidData(val: Int?) -> Bool {
        let value = val ?? 0
        if 1...10 ~= value {
            return true
        } else {
            return false
        }
    }

    func mapAndCheckData() -> ([String: Any]?, String?) {
        var errorMessage: String?
        let isNotValid = AppLocalization.isNotValid
        switch true {
        case (customTransformer.name ?? "").count == 0:
            errorMessage = Features.name.rawValue + isNotValid
        case !self.checkValidData(val: customTransformer.strength):
            errorMessage = Features.strength.rawValue + isNotValid
        case !self.checkValidData(val: customTransformer.intelligence):
            errorMessage = Features.intelligence.rawValue + isNotValid
        case !self.checkValidData(val: customTransformer.speed):
            errorMessage = Features.speed.rawValue + isNotValid
        case  !self.checkValidData(val: customTransformer.endurance):
            errorMessage = Features.endurance.rawValue + isNotValid
        case !self.checkValidData(val: customTransformer.rank):
            errorMessage = Features.rank.rawValue + isNotValid
        case !self.checkValidData(val: customTransformer.courage):
            errorMessage = Features.courage.rawValue + isNotValid
        case !self.checkValidData(val: customTransformer.firepower):
            errorMessage = Features.firepower.rawValue + isNotValid
        case !self.checkValidData(val: customTransformer.skill):
            errorMessage = Features.skill.rawValue + isNotValid

        default:
            break
        }

        if let errorMessage = errorMessage {
            return (nil, errorMessage)
        }

        var dict = [String: Any]()
        dict[CustomTransformer.SerializationKeys.courage] = customTransformer.courage
        dict[CustomTransformer.SerializationKeys.endurance] = customTransformer.endurance
        dict[CustomTransformer.SerializationKeys.firepower] = customTransformer.firepower
        dict[CustomTransformer.SerializationKeys.intelligence] = customTransformer.intelligence
        dict[CustomTransformer.SerializationKeys.name] = customTransformer.name
        dict[CustomTransformer.SerializationKeys.rank] = customTransformer.rank
        dict[CustomTransformer.SerializationKeys.speed] = customTransformer.speed
        dict[CustomTransformer.SerializationKeys.strength] = customTransformer.strength
        dict[CustomTransformer.SerializationKeys.skill] = customTransformer.skill
        return (dict, nil)
    }

    /// Send Data to server
    /// - Parameter customTransformer: CustomTransformer's object
    func sendData(customTransformer: CustomTransformer) {
        let value = self.mapAndCheckData()
        if let errorMessage = value.1 {
            self.showErrorAlert?(errorMessage, false)
            return
        }

        guard var dict = value.0 else {
            return
        }

        if let id = customTransformer.id, id.count > 0 {
            dict[CustomTransformer.SerializationKeys.id] = id
        } else {
            dict[CustomTransformer.SerializationKeys.id] = 0
        }
        if team == Team.autobots {
            dict[CustomTransformer.SerializationKeys.team] = "A"
        } else if team == Team.decepticons {
            dict[CustomTransformer.SerializationKeys.team] = "D"
        }

        var callType: ApiCall = .addData
        switch operation {
        case .add:
            callType = .addData
        case .edit:
            callType = .editData
        }
        self.handleNetWorkCall(dict: dict, callType: callType)
    }

    /// Send request to network manager
    /// - Parameters:
    ///   - dict: paramaeters of request
    ///   - callType: which api to call
    func handleNetWorkCall(dict: [String: Any], callType: ApiCall) {
        self.showLoader?()
        networkManager.getDataFromApi(type: Transformer.self,
                                      call: callType, postData: dict) { [weak self] (_, error)  in
                                        self?.removeLoader?()
                                        if error != nil {
                                            self?.showErrorAlert?(AppLocalization.AlertStrings.errorMessage, true)
                                        } else {
                                            self?.showAlert?()
                                        }
        }
    }
}
