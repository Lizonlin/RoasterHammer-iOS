//
//  CreateAccountView.swift
//  RoasterHammer
//
//  Created by Thibault Klein on 2/28/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import Foundation

protocol CreateAccountView: class {
    func didRegister()
    func didReceiveError(_ error: Error)
}
