//
//  AccountNetworking.swift
//  RoasterHammer
//
//  Created by Thibault Klein on 2/25/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import Foundation
import Alamofire
import RoasterHammerShared

final class AccountNetworking: ResponseHandling {

    func createAccount(request: CreateUserRequest, completion: @escaping (HTTPResponse?, Error?) -> Void) {
        Alamofire
            .request("http://localhost:8080/users/register",
                     method: .post,
                     parameters: request.toJSON(),
                     encoding: JSONEncoding.default,
                     headers: ["Content-Type": "application/json"])
            .responseData { [weak self] response in
                self?.handleResponse(response: response, completion: completion)
        }
    }

    func login(basicToken: String, completion: @escaping (HTTPResponse?, Error?) -> Void) {
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Basic \(basicToken)"
        ]

        Alamofire
            .request("http://localhost:8080/users/login",
                     method: .post,
                     encoding: JSONEncoding.default,
                     headers: headers)
            .responseData { [weak self] response in
                self?.handleResponse(response: response, completion: completion)
        }
    }

}

extension CreateUserRequest: JSONConvertible {
    func toJSON() -> JSON {
        return ["email": self.email, "password": self.password]
    }
}
