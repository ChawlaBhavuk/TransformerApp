//
//  TransformerHeaderView.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit

protocol TransformerHeaderViewDelegate: class {
    func toggleSection(header: TransformerHeaderView, section: Int)
}

class TransformerHeaderView: UITableViewHeaderFooterView {

    var item: TransformerListViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }

            titleLabel?.text = item.sectionTitle
            setCollapsed(collapsed: item.isCollapsed)
        }
    }

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var arrowLabel: UILabel?
    var section: Int = 0

    weak var delegate: TransformerHeaderViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }

    /// Even called when you tap header
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }

    /// Change arrow direction
    /// - Parameter collapsed: check header is collapsed or not
    func setCollapsed(collapsed: Bool) {
        arrowLabel?.rotate(collapsed ? 0.0 : .pi)
    }
}
