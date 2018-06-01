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
    
    static let server = "http://www.pingpangwang.com"
    
    class func forumList(_ response: @escaping ([PP_ForumModel?]) -> ()) {
        let url = "/mobcent/app/web/index.php?r=forum/forumlist"
        Alamofire.request(server+url).responseData(completionHandler: { (handler) in
            guard let value = handler.result.value else { return }
            let json = JSON(data: value)
            print(json)
            
            if let modelList = [PP_ForumModel].deserialize(from: json.rawString(), designatedPath: "list") {
                response(modelList)
            }
        })
    }
    
    class func topicListEx(boardId: String, page : Int, _ response: @escaping ([PP_TopicModel?]) -> ()) {
        let url = "/mobcent/app/web/index.php?r=forum/topiclistex"
        let parameters: Parameters = ["boardId": boardId, "page": page]
        
//        $boardId, $page = 1, $pageSize = 10, $orderby = 'all',  $sortid = '', $sorts = '', $circle = 0
        
        Alamofire.request(server+url, parameters: parameters).responseData(completionHandler: { (handler) in
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
    
    class func postList(boardId: String, topicId: String, page: Int, _ response: @escaping (TopicDetailModel?, [PP_CommentModel?]?) -> ()) {
        let url = "/mobcent/app/web/index.php?r=forum/postlist"
        let parameters: Parameters = ["boardId": boardId, "topicId": topicId, "page": page]
        
        Alamofire.request(server+url, parameters: parameters).responseData(completionHandler: { (handler) in
            guard let value = handler.result.value else { return }
            let json = JSON(data: value)
            print(json)
            
            let topic = TopicDetailModel.deserialize(from: json.rawString(), designatedPath: "topic")
            let list = [PP_CommentModel].deserialize(from: json.rawString(), designatedPath: "list")
            response(topic, list)
        })
    }
    
    class func registUser(boardId: String, topicId: String, _ response: @escaping (TopicDetailModel?, [PP_CommentModel?]?) -> ()) {
        let url = "/mobcent/app/web/index.php?r=user/register"
        let parameters: Parameters = ["username": boardId, "password": topicId]
        
        Alamofire.request(server+url, parameters: parameters).responseData(completionHandler: { (handler) in
            guard let value = handler.result.value else { return }
            let json = JSON(data: value)
            print(json)
            
            let topic = TopicDetailModel.deserialize(from: json.rawString(), designatedPath: "topic")
            let list = [PP_CommentModel].deserialize(from: json.rawString(), designatedPath: "list")
            response(topic, list)
        })
    }
    
    class func loginUser(username: String, password: String, _ response: @escaping (PP_UserModel?) -> ()) {
        let url = "/mobcent/app/web/index.php?r=user/login"
        let parameters: Parameters = ["username": username, "password": password]
        
        Alamofire.request(server+url, parameters: parameters).responseData(completionHandler: { (handler) in
            guard let value = handler.result.value else {
                let des = handler.error?.localizedDescription
                cmShowToast(des)
                return
            }
            let json = JSON(data: value)
            print(json)
            let model = PP_UserModel.deserialize(from: json.rawString())
            response(model)
        })
    }
    
}


//{
//    "score" : 10,
//    "body" : {
//        "externInfo" : {2018-05-17 00:10:59.428342+0800 PingPangWang[13592:1461670] [BoringSSL] Function boringssl_session_errorlog: line 2881 [boringssl_session_read] SSL_ERROR_ZERO_RETURN(6): operation failed because the connection was cleanly shut down with a close_notify alert
//
//            "padding" : ""
//        }
//    },
//    "mobile" : "",
//    "token" : "b523a0b55c06930cfec15774de9a1",
//    "groupid" : 11,
//    "userName" : "18610249537",
//    "gender" : 0,
//    "creditShowList" : [
//    {
//    "type" : "credits",
//    "title" : "积分",
//    "data" : 10
//    },
//    {
//    "type" : "extcredits2",
//    "title" : "乒乓币",
//    "data" : 4
//    }
//    ],
//    "head" : {
//        "errInfo" : "调用成功,没有任何错误",
//        "alert" : 0,
//        "errCode" : "00000000",
//        "version" : "2.8.1.5"
//    },
//    "uid" : 348978,
//    "isValidation" : 0,
//    "repeatList" : [
//
//    ],
//    "userTitle" : "LV2乒乓爱好者",
//    "errcode" : "",
//    "secret" : "29fbd6e15beb6b88af05520347a23",
//    "rs" : 1,
//    "verify" : [
//
//    ],
//    "avatar" : "http:\/\/www.pingpangwang.com\/uc_server\/avatar.php?uid=348978&size=middle"
//}

