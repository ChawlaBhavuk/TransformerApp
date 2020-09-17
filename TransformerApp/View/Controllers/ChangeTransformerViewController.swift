//
//  ChangeTransformerViewController.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 17/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit
import SVProgressHUD

class ChangeTransformerViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet {
            segmentControl.setTitle(AppLocalization.Teams.autobots, forSegmentAt: 0)
            segmentControl.setTitle(AppLocalization.Teams.decepticons, forSegmentAt: 1)
        }
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellClass: FeatureFieldTableViewCell.self)
        }
    }

    var viewModel = ChangeTransformerViewModal()
    var transformer: Transformer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = AppLocalization.tranformers
        viewModel.team = .autobots
        self.responseHandlerFromviewModel()
    }

    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.team = .autobots
        case 1:
            viewModel.team = .decepticons
        default:
            break
        }
    }

    @IBAction func submitClicked(_ sender: UIButton) {
        viewModel.sendData(customTransformer: viewModel.customTransformer)
    }

    // MARK: Data handler from view model

    /// handling responses from view model
    func responseHandlerFromviewModel() {
        viewModel.changeTeam = { [weak self] team in
            self?.segmentControl.selectedSegmentIndex = team.rawValue
        }

        if let transformer = transformer {
            viewModel.setData(transformer: transformer)
        }

        viewModel.showAlert = { [weak self] in
            DispatchQueue.main.async {
                self?.showAlert()
            }
        }

        viewModel.showErrorAlert = { [weak self] message in
            DispatchQueue.main.async {
                self?.showErrorAlert(error: message)
            }
        }

        self.viewModel.showLoader = {
            SVProgressHUD.show(withStatus: AppLocalization.loading)
        }

        self.viewModel.removeLoader = {
            SVProgressHUD.dismiss()
        }

    }

    /// showing alert on error
    ///
    /// - Parameter error: title for error
    func showErrorAlert(error: String) {
        let alert = UIAlertController(title: AppLocalization.AlertStrings.success,
                                      message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AppLocalization.AlertStrings.retry,
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in

        }))
        alert.addAction(UIAlertAction(title: AppLocalization.AlertStrings.cancel,
                                      style: UIAlertAction.Style.cancel,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    /// For  data alert
    func showAlert() {
        let alert = UIAlertController(title: AppLocalization.AlertStrings.success,
                                      message: AppLocalization.AlertStrings.dataSaved,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AppLocalization.AlertStrings.okString,
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in
                                        self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: TableView Delegates
extension ChangeTransformerViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Features.allCases.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeatureFieldTableViewCell = tableView.dequeue(cellClass:
            FeatureFieldTableViewCell.self, forIndexPath: indexPath)
        cell.delegate = self
        cell.setData(value: Features.allCases[indexPath.row].rawValue.localized(),
                     type: Features.allCases[indexPath.row],
                     customTransformer: viewModel.customTransformer)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

// MARK: Textfield dat storage Delegates
extension ChangeTransformerViewController: HandleTextField {
    func data(value: String?, type: Features) {
        viewModel.handleData?(value, type)
    }
}
