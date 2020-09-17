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
        static let success = "success".localized()
        static let errorMessage = "Some Error occurs please try again!!".localized()
        static let retry = "Retry".localized()
        static let cancel = "Cancel".localized()
        static let okString = "Ok".localized()
        static let dataSaved = "Data Saved Successfully".localized()
    }

    static let tranformers = "Tranformers".localized()
    static let tranformersList = "Tranformers List".localized()
    static let deliveryDetails = "Delivery Details".localized()
    static let atString = "at".localized()
    static let noInternetConnection = "No internet Connection available. Please Try Again.".localized()

    static let loading = "Loading".localized() + "..."

    static let noData = "No data found.".localized()
    static let pullToRefresh = "Pull to Refresh for Data".localized()
}
