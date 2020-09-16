//
//  ViewController.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var networkManager = NetworkManager()

        networkManager.getDataFromApi(type: WelcomeTransformers.self,
                                      call: .getData) { [weak self] jsonData, errorMessage  in
        print(jsonData)
        }
        // Do any additional setup after loading the view.
    }


}
