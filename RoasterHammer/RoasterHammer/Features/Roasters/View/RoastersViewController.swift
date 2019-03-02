//
//  RoastersViewController.swift
//  RoasterHammer
//
//  Created by Thibault Klein on 2/28/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import Foundation
import UIKit
import RoasterHammerShared

final class RoastersViewController: RoastersLayoutViewController {
    var interactor: RoastersViewOutput!
    var router: RoastersRouter!
    var roasters: [RoasterResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Roasters"
        let accountButton = UIBarButtonItem(title: "Profile",
                                            style: .plain,
                                            target: self,
                                            action: #selector(accountButtonTapped(_:)))
        let addRoasterButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addRoasterButtonTapped(_:)))
        navigationItem.leftBarButtonItem = accountButton
        navigationItem.rightBarButtonItem = addRoasterButton

        tableView.delegate = self
        tableView.dataSource = self
        router.navigationController = navigationController

        interactor.getRoasters()
    }

    @objc private func accountButtonTapped(_ sender: UIBarButtonItem) {
        interactor.accountButtonTapped()
    }

    @objc private func addRoasterButtonTapped(_ sender: UIBarButtonItem) {
        interactor.addRoasterButtonTapped()
    }

}

extension RoastersViewController: RoastersView {
    func displayRoasters(roasters: [RoasterResponse]) {
        self.roasters = roasters
        tableView.reloadData()
    }

    func didReceiveError(_ error: Error) {
        let alert = Alerter().informationalAlert(title: "Error", message: error.localizedDescription)
        present(alert, animated: true, completion: nil)
    }

    func presentLoginView() {
        router.presentLoginView()
    }
}

extension RoastersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoasterTableViewCell = tableView.dequeueIdentifiableCell(for: indexPath)
        return cell
    }

}

extension RoastersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }

}
