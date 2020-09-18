//
//  AppLocalization.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation

struct AppLocalization {

    struct TransformersList {
        static let strength = "Strength".localized()
        static let speed = "Speed".localized()
        static let endurance = "Endurance".localized()
        static let courage = "Courage".localized()
        static let firepower = "Firepower".localized()
        static let skill = "Skill".localized()
        static let rank = "Rank".localized()
        static let intelligence = "Intelligence".localized()
    }

     struct Teams {
         static let decepticons = "Decepticons".localized()
         static let autobots = "Autobots".localized()
     }

    struct Actions {
        static let delete = "Delete".localized()
        static let edit = "Edit".localized()
    }
    struct AlertStrings {
        static let success = "Success".localized()
        static let warning = "Warning".localized()
        static let errorMessage = "Some Error occurs please try again!!".localized()
        static let retry = "Retry".localized()
        static let cancel = "Cancel".localized()
        static let okString = "Ok".localized()
        static let dataSaved = "Data Saved Successfully".localized()
    }

    struct Battle {
         static let tieMatch = "Tie match".localized()
         static let autobotsWin = "Autobots Win".localized()
         static let decepticonsWin = "Decepticons Win".localized()

    }

    static let tranformers = "Tranformers".localized()
    static let tranformersList = "Tranformers List".localized()
    static let noInternetConnection = "No internet Connection available. Please Try Again.".localized()
    static let loading = "Loading".localized() + "..."
    static let noData = "No data found.".localized()
    static let addData = "Click on Add to add new Transformer".localized()
    static let noSurvivor = "No Survivor".localized()
    static let survivors = "Survivors".localized()
    static let noTransformer = "No Transformer for Battle".localized()
    static let isNotValid = " is not valid".localized()
}
