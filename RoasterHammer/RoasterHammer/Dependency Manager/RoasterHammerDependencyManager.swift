//
//  RoasterHammerDependencyManager.swift
//  RoasterHammer
//
//  Created by Thibault Klein on 2/28/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import Foundation
import UIKit

final class RoasterHammerDependencyManager: DependencyManager {
    var environmentManager: HTTPEnvironmentManager
    static let shared = RoasterHammerDependencyManager()

    init() {
        let localEnvironment = HTTPEnvironment(name: "Local", baseURL: URL(string: "http://localhost:8080")!)
        environmentManager = RoasterHammerEnvironmentManager(currentEnvironment: localEnvironment, environments: [localEnvironment])
    }

    // MARK: - DependencyManager

    func startApplication(window: UIWindow?) {
        let roastersViewController = self.roastersBuilder().build()
        let navigationController = UINavigationController(rootViewController: roastersViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    // MARK: - FeatureFactory

    func loginBuilder() -> LoginBuildable {
        return LoginBuilder(dependencyManager: RoasterHammerDependencyManager.shared)
    }

    func createAccountBuilder() -> CreateAccountBuildable {
        return CreateAccountBuilder(dependencyManager: RoasterHammerDependencyManager.shared)
    }

    func roastersBuilder() -> RoastersBuildable {
        return RoastersBuilder(dependencyManager: RoasterHammerDependencyManager.shared)
    }
}