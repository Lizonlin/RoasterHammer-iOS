//
//  RoastersInteractor.swift
//  RoasterHammer
//
//  Created by Thibault Klein on 2/28/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import RoasterHammer_Shared

final class RoastersInteractor: RoastersViewOutput, ObservableObject {
    var roasters: [RoasterResponse] = [] {
        didSet {
            willChange.send(self)
        }
    }
    var willChange = PassthroughSubject<RoastersInteractor, Never>()

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
                self?.roasters = roasters
            } else if let _ = error {
                self?.roasters = []
            }
        }
    }

    func createRoaster(name: String) {
        roastersDataManager.createRoaster(name: name) { [weak self] (roaster, error) in
            if roaster != nil {
                self?.getRoasters()
            }
        }
    }

    func removeRoster(rosterId: Int) {
        roastersDataManager.removeRoster(rosterId: rosterId) { [weak self] (rosters, error) in
            if let rosters = rosters {
                self?.roasters = rosters
            }
        }
    }
}
