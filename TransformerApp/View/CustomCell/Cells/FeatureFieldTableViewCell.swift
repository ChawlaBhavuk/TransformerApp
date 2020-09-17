//
//  FeatureFieldTableViewCell.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 17/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit

protocol HandleTextField: AnyObject {
    func data(value: String?, type: Features)
}

class FeatureFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
            textField.tintColor = UIColor.black
        }
    }
    weak var delegate: HandleTextField?
    var type: Features?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }

    /// set data to view
    /// - Parameters:
    ///   - value: name of field
    ///   - type: feature type of field
    func setData(value: String, type: Features, customTransformer: CustomTransformer) {
        self.type = type
        if type == .name {
            textField.keyboardType = .default
        } else {
            textField.keyboardType = .numberPad
        }
        textField.text = ""
        nameLabel.text = value + ":-"
        switch type {
        case .strength:
            textField.text = customTransformer.strength?.description
        case .intelligence:
            textField.text = customTransformer.intelligence?.description
        case .speed:
            textField.text = customTransformer.speed?.description
        case .endurance:
            textField.text = customTransformer.endurance?.description
        case .rank:
            textField.text = customTransformer.rank?.description
        case .courage:
            textField.text = customTransformer.courage?.description
        case .firepower:
            textField.text = customTransformer.firepower?.description
        case .skill:
            textField.text = customTransformer.skill?.description
        case .name:
            textField.text = customTransformer.name?.description
        }
    }

}

extension FeatureFieldTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let type = self.type, type == .name {
            return true
        }
        if range.length == 1 {
            return true
        }
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)),
            let text = textField.text, text.count == 0, string.count == 1 else {
            return false
        }
        return true
    }

    /// Check textField's changed or not
    /// - Parameter textField: textField's object
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let type = self.type else { return  }
        delegate?.data(value: textField.text, type: type)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let type = self.type else { return  }
        delegate?.data(value: textField.text, type: type)
    }
}
