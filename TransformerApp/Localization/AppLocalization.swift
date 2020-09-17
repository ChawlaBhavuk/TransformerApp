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
        static let strength = "Strength"
        static let speed = "Speed"
        static let endurance = "Endurance"
        static let courage = "Courage"
        static let firepower = "Firepower"
        static let skill = "Skill"
        static let rank = "Rank"
        static let intelligence = "Intelligence"
    }

     struct Teams {
         static let decepticons = "Decepticons"
         static let autobots = "Autobots"
     }

    static let warning = "Warning".localized()
    static let errorMessage = "Some Error occurs please try again!!".localized()
    static let retry = "Retry".localized()
    static let tranformers = "Tranformers".localized()
    static let deliveryDetails = "Delivery Details".localized()
    static let atString = "at".localized()
    static let noInternetConnection = "No internet Connection available. Please Try Again.".localized()
    static let cancel = "Cancel".localized()
    static let loading = "Loading".localized() + "..."
    static let okString = "Ok".localized()
    static let noData = "No data found.".localized()
    static let pullToRefresh = "Pull to Refresh for Data".localized()
}
