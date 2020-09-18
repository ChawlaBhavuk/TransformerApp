//
//  SurvivorViewController.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit

class SurvivorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellClass: TranformersTableViewCell.self)
        }
    }
    var survivors = [Transformer]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = AppLocalization.survivors
        if survivors.count > 0 {
            self.tableView.resetBackgroundView()
        } else {
            self.tableView.setEmptyView(title: AppLocalization.noData, message: AppLocalization.noSurvivor)
        }
        self.tableView.reloadData()
    }
}

// MARK: TableView Delegates
extension SurvivorViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return survivors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TranformersTableViewCell = tableView.dequeue(cellClass:
            TranformersTableViewCell.self, forIndexPath: indexPath)
        cell.item = survivors[indexPath.row]
        return cell
    }
}
