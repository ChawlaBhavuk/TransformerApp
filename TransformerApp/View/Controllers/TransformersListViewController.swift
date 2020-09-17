//
//  ViewController.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit
import SVProgressHUD

class TransformersListViewController: UIViewController {

    var viewModel = TransformerListViewModal()

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellClass: TranformersTableViewCell.self)
            tableView.registerHeader(headerClass: TransformerHeaderView.self)
        }
    }
    @IBOutlet weak var battleBtn: UIButton!

    var networkManager: NetworkRouter = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = AppLocalization.tranformersList
        self.responseHandlerFromViewModal()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchTransformers()
    }

    @IBAction private func addButtonClicked(_ sender: UIBarButtonItem) {
        self.pushToAddEditTransformer()
    }

    @IBAction private func battleClicked(_ sender: UIButton) {
    }

    @IBAction private func clearClicked(_ sender: UIBarButtonItem) {
        viewModel.clearSession()
    }

    private func pushToAddEditTransformer(transformer: Transformer? = nil) {
        guard let newViewController = self.storyboard?.instantiateViewController(withIdentifier:
            ChangeTransformerViewController.className) as? ChangeTransformerViewController else {
                return
        }
        newViewController.transformer = transformer
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    // MARK: Data handler from view model

    /// handling responses from view model
    private func responseHandlerFromViewModal() {

        self.viewModel.showLoader = {
            SVProgressHUD.show(withStatus: AppLocalization.loading)
        }

        self.viewModel.removeLoader = {
            SVProgressHUD.dismiss()
        }

        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.battleBtn.isHidden = false
                self?.tableView.resetBackgroundView()
                self?.tableView.reloadData()
            }
        }

        viewModel.reloadSections = { [weak self] (section: Int) in
            self?.tableView?.beginUpdates()
            self?.tableView?.reloadSections([section], with: .fade)
            self?.tableView?.endUpdates()
        }

        viewModel.reloadDataWithEmptyMessage = { [weak self] in
            DispatchQueue.main.async {
                self?.battleBtn.isHidden = true
                self?.tableView.setEmptyView(title: AppLocalization.noData, message: AppLocalization.addData)
                self?.tableView.reloadData()
            }
        }
    }

}

// MARK: TableView Delegates
extension TransformersListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueHeader(headerClass: TransformerHeaderView.self)
        headerView.section = section
        headerView.item = viewModel.items[section]
        headerView.delegate = self
        return headerView
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.items[section].isCollapsed {
            return viewModel.items[section].transformer.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TranformersTableViewCell = tableView.dequeue(cellClass:
            TranformersTableViewCell.self, forIndexPath: indexPath)
        cell.item = viewModel.items[indexPath.section].transformer[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteAction = UITableViewRowAction(style: .destructive,
                                                title: AppLocalization.Actions.delete) { _, _ in
        self.viewModel.deleteTransformer(id: self.viewModel.items[indexPath.section].transformer[indexPath.row].id)
        }
        let editAction = UITableViewRowAction(style: .normal,
                                              title: AppLocalization.Actions.edit) { _, _ in
        self.pushToAddEditTransformer(transformer:
            self.viewModel.items[indexPath.section].transformer[indexPath.row])

        }
        editAction.backgroundColor = .green
        return [deleteAction, editAction]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

// MARK: TableView Header Delegates
extension TransformersListViewController: TransformerHeaderViewDelegate {
    func toggleSection(header: TransformerHeaderView, section: Int) {
        var item = viewModel.items[section]
        let collapsed = !item.isCollapsed
        item.isCollapsed = collapsed
        header.setCollapsed(collapsed: collapsed)
        viewModel.reloadSections?(section)
    }
}
