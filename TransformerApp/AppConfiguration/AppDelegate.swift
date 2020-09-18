//
//  AppDelegate.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        print(KeychainWrapper.standard.string(forKey: AppStrings.token) ?? "")
        return true
    }
}

extension AppDelegate {
    class func delegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}
