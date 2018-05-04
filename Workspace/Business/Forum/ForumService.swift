//
//  ForumService.swift
//  CommonSwift
//
//  Created by LpSun on 2018/4/13.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import Moya
import Alamofire
import SwiftyJSON

class ForumService: NSObject {
    class func forumList(_ response: @escaping ([PP_ForumModel?]) -> ()) {
        let url = "http://www.pingpangwang.com/mobcent/app/web/index.php?r=forum/forumlist"
        Alamofire.request(url).responseData(completionHandler: { (handler) in
            guard let value = handler.result.value else { return }
            let json = JSON(data: value)
            print(json)
            
            if let modelList = [PP_ForumModel].deserialize(from: json.rawString(), designatedPath: "list") {
                response(modelList)
            }
        })
    }
    
    class func topicListEx(boardId: String, _ response: @escaping ([PP_TopicModel?]) -> ()) {
        let url = "http://www.pingpangwang.com/mobcent/app/web/index.php?r=forum/topiclistex"
        let parameters: Parameters = ["boardId": boardId]
        
//        $boardId, $page = 1, $pageSize = 10, $orderby = 'all',  $sortid = '', $sorts = '', $circle = 0
        
        Alamofire.request(url, parameters: parameters).responseData(completionHandler: { (handler) in
            guard let value = handler.result.value else { return }
            let json = JSON(data: value)
            print(json)
            
            if let modelList = [PP_TopicModel].deserialize(from: json.rawString(), designatedPath: "list") {
                response(modelList)
            }
        })
    }
    
    
//    http://www.pingpangwang.com//mobcent/app/web/index.php?r=forum/postlist
//    packageName=com.appbyme.app163160&forumType=7&pageSize=10&appName=%E4%B9%92%E4%B9%93%E7%BD%91&topicId=29805&authorId=0&egnVersion=v2102.5&sdkVersion=2.5.0.0&imei=a000005551a593&apphash=9d215201&boardId=65&forumKey=pMvx2iqKu3lITwzCjp&page=1&platType=1&imsi=&sdkType=
    
    class func postList(boardId: String, topicId: String, _ response: @escaping (TopicDetailModel?) -> ()) {
        let url = "http://www.pingpangwang.com//mobcent/app/web/index.php?r=forum/postlist"
        let parameters: Parameters = ["boardId": boardId, "topicId": topicId]
        
        Alamofire.request(url, parameters: parameters).responseData(completionHandler: { (handler) in
            guard let value = handler.result.value else { return }
            let json = JSON(data: value)
            print(json)
            
            if let topicDetail = TopicDetailModel.deserialize(from: json.rawString(), designatedPath: "topic") {
                response(topicDetail)
            }
        })
    }
    
}



//enum ForumService {
//    case forumlist
//    case showUser(id: Int)
//    case createUser(firstName: String, lastName: String)
//    case updateUser(id: Int, firstName: String, lastName: String)
//    case showAccounts
//}
//
//extension ForumService: TargetType {
//    var baseURL: URL { return URL(string: "http://www.pingpangwang.com/mobcent/app/web/index.php?r=forum/forumlist")! }
//    var path: String {
//        switch self {
//        case .forumlist:
//            return ""
//        case .showUser(let id), .updateUser(let id, _, _):
//            return "/users/\(id)"
//        case .createUser(_, _):
//            return "/users"
//        case .showAccounts:
//            return "/accounts"
//        }
//    }
//    var method: Moya.Method {
//        switch self {
//        case .forumlist, .showUser, .showAccounts:
//            return .get
//        case .createUser, .updateUser:
//            return .post
//        }
//    }
//    var task: Task {
//        switch self {
//        case .forumlist, .showUser, .showAccounts: // Send no parameters
//            return .requestPlain
//        case let .updateUser(_, firstName, lastName):  // Always sends parameters in URL, regardless of which HTTP method is used
//            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: URLEncoding.queryString)
//        case let .createUser(firstName, lastName): // Always send parameters as JSON in request body
//            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)
//        }
//    }
//    var sampleData: Data {
//        switch self {
//        case .forumlist:
//            return "Half measures are as bad as nothing at all.".utf8Encoded
//        case .showUser(let id):
//            return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".utf8Encoded
//        case .createUser(let firstName, let lastName):
//            return "{\"id\": 100, \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
//        case .updateUser(let id, let firstName, let lastName):
//            return "{\"id\": \(id), \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
//        case .showAccounts:
//            // Provided you have a file named accounts.json in your bundle.
//            guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
//                let data = try? Data(contentsOf: url) else {
//                    return Data()
//            }
//            return data
//        }
//    }
//    var headers: [String: String]? {
//        return ["Content-type": "application/json"]
//    }
//}
//// MARK: - Helpers
//private extension String {
//    var urlEscaped: String {
//        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
//    }
//
//    var utf8Encoded: Data {
//        return data(using: .utf8)!
//    }
//}

