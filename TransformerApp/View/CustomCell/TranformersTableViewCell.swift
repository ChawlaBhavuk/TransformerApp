//
//  TranformersTableViewCell.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit
import Kingfisher

class TranformersTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var imgeView: UIImageView!
    @IBOutlet weak var parentView: UIView! {
        didSet {
            parentView.applyShadow()
        }
    }

    var item: Transformer? {
        didSet {
            guard let item = item else {
                return
            }
            nameLbl.text = item.name + "," + AppStrings.TransformersList.rank + ": " + String(item.rank)
            let formatedString = String.init(format: "%@: %i, %@: %i, %@: %i, %@: %i, %@: %i, %@: %i, %@: %i",
                                             AppStrings.TransformersList.strength, item.strength,
                                             AppStrings.TransformersList.intelligence, item.intelligence,
                                             AppStrings.TransformersList.speed, item.speed,
                                             AppStrings.TransformersList.endurance, item.endurance,
                                             AppStrings.TransformersList.courage, item.courage,
                                             AppStrings.TransformersList.firepower, item.firepower,
                                             AppStrings.TransformersList.skill, item.skill)
            descLbl.text = formatedString
            if let url = URL(string: item.teamIcon) {
                self.imgeView.kf.setImage(with: url,
                                               placeholder: UIImage(named: "placeholder"),
                                               options: nil, progressBlock: nil) { _ in
                }
            }
        }
    }

}
