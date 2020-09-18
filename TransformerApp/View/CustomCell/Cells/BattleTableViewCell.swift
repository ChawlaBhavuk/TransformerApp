//
//  BattleTableViewCell.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit

class BattleTableViewCell: UITableViewCell {

    @IBOutlet weak var bImage: UIImageView!
    @IBOutlet weak var aImage: UIImageView!
    @IBOutlet weak var dTeamName: UILabel!
    @IBOutlet weak var dTeamLabel: UILabel!
    @IBOutlet weak var aTeamName: UILabel!
    @IBOutlet weak var aTeamLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var parentView: UIView! {
        didSet {
            parentView.applyShadow()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        aImage.isHidden = true
        bImage.isHidden = true
    }

    var item: BattleModel? {
        didSet {
            guard let item = item else {
                return
            }
            aTeamLabel.text = AppLocalization.Teams.autobots
            dTeamLabel.text = AppLocalization.Teams.decepticons
            if item.winner == .autobot {
                aImage.isHidden = false
                bImage.isHidden = true
            } else if item.winner == .decepticon {
                aImage.isHidden = true
                bImage.isHidden = false
            } else {
                aImage.isHidden = true
                bImage.isHidden = true
            }
            dTeamName.text = item.deception.name
            aTeamName.text = item.autobot.name
            detailLabel.text = item.winnerDetail.rawValue
        }
    }
}
