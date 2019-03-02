//
//  RoastersInteractor.swift
//  RoasterHammer
//
//  Created by Thibault Klein on 2/28/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import Foundation

final class RoastersInteractor: RoastersViewOutput {
    var presenter: RoastersInteractorOutput!
    private let accountDataManager: AccountDataManager
    private let roastersDataManager: RoasterDataManager

    init(accountDataManager: AccountDataManager,
         roastersDataManager: RoasterDataManager) {
        self.accountDataManager = accountDataManager
        self.roastersDataManager = roastersDataManager
    }

    func getRoasters() {
        roastersDataManager.getRoasters { [weak self] (roasters, error) in
            if let roasters = roasters {
                self?.presenter.didReceiveRoasters(roasters: roasters)
            } else if let error = error {
                self?.presenter.didReceiveError(error)
            }
        }
    }

    func accountButtonTapped() {
        if !accountDataManager.isUserLoggedIn() {
            presenter.shouldPresentLoginView()
        }
        // TODO: if user is logged in, inform presenter to show the account page
    }

    func addRoasterButtonTapped() {
        // TODO
        roastersDataManager.createRoaster(name: "Test Roaster") { [weak self] (roaster, error) in
            if let roaster = roaster {
                self?.presenter.didReceiveRoasters(roasters: [roaster])
            } else if let error = error {
                self?.presenter.didReceiveError(error)
            }
        }
    }


}
