//
//  Moya.swift
//  RxMoyaExample
//
//  Created by chendi li on 2017/7/4.
//  Copyright © 2017年 dcubot. All rights reserved.
//

import Foundation
import Moya

enum MyAPI {
    case login(username: String, password: String)
}

extension MyAPI: TargetType {
    public var baseURL: URL { return URL(string: "https://baseurl.com/v1")! }
    public var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    public var task: Task {
        switch self {
        case let .login(username, password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: URLEncoding.queryString)
        }
    }
    public var validationType: ValidationType {
        return .none
    }
    public var sampleData: Data {
        return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
    }
    public var headers: [String: String]? {
        return nil
    }
}
