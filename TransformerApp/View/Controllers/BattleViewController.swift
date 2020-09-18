//
//  BattleViewController.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 18/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellClass: BattleTableViewCell.self)
        }
    }

    var viewModel: BattleViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.responseHandlerFromViewModal()
        viewModel.format()
    }

    // MARK: Data handler from view model

    /// handling responses from view model
    private func responseHandlerFromViewModal() {

        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationItem.title = self?.viewModel.result
                self?.tableView.resetBackgroundView()
                self?.tableView.reloadData()
            }
        }

        viewModel.reloadDataWithEmptyMessage = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationItem.title = AppLocalization.noData
                self?.tableView.setEmptyView(title: AppLocalization.noData,
                                             message: AppLocalization.noTransformer)
                self?.tableView.reloadData()
            }
        }
    }

    @IBAction func survivorClicked(_ sender: UIButton) {
       guard let newViewController = self.storyboard?.instantiateViewController(withIdentifier:
           SurvivorViewController.className) as? SurvivorViewController else {
               return
       }
        newViewController.survivors = viewModel.survivors
       self.navigationController?.pushViewController(newViewController, animated: true)
    }

}

// MARK: TableView Delegates
extension BattleViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.battleModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BattleTableViewCell = tableView.dequeue(cellClass:
                    BattleTableViewCell.self, forIndexPath: indexPath)
        cell.item = viewModel.battleModel[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
