//
//  DemoRequest.swift
//  CommonSwift
//
//  Created by lipeng on 2017/3/6.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import Alamofire

class BookRequest: CMRequest {
    
    override init() {
        super.init()
//        url = "http://localhost:8080/CommonServer/servlet/validCodeImg"
//        parameters = ["file_name": "swift_file.jpeg"]
        
        url = "/v2/book/1220562"
        parameters = ["q" : "我的家乡"]
        method = .get
        responseModel = BookModel.self
    }
}



//{
//    "translator" : [
//    "豫人"
//    ],
//    "binding" : "平装",
//    "alt" : "https:\/\/book.douban.com\/subject\/1220562\/",
//    "author_intro" : "",
//    "rating" : {
//        "min" : 0,
//        "average" : "7.0",
//        "max" : 10,
//        "numRaters" : 358
//    },
//    "tags" : [
//    {
//    "count" : 142,
//    "name" : "片山恭一",
//    "title" : "片山恭一"
//    },
//    {
//    "count" : 68,
//    "name" : "日本",
//    "title" : "日本"
//    },
//    {
//    "count" : 64,
//    "name" : "日本文学",
//    "title" : "日本文学"
//    },
//    {
//    "count" : 40,
//    "name" : "小说",
//    "title" : "小说"
//    },
//    {
//    "count" : 33,
//    "name" : "满月之夜白鲸现",
//    "title" : "满月之夜白鲸现"
//    },
//    {
//    "count" : 15,
//    "name" : "爱情",
//    "title" : "爱情"
//    },
//    {
//    "count" : 9,
//    "name" : "純愛",
//    "title" : "純愛"
//    },
//    {
//    "count" : 7,
//    "name" : "外国文学",
//    "title" : "外国文学"
//    }
//    ],
//    "price" : "15.00元",
//    "catalog" : "\n      ",
//    "author" : [
//    "[日] 片山恭一"
//    ],
//    "summary" : "那一年，是听莫扎特、钓鲈鱼和家庭破裂的一年。说到家庭破裂，母亲怪自己当初没有找到好男人，父亲则认为当时是被狐狸精迷住了眼，失常的是母亲，但出问题的是父亲……。",
//    "publisher" : "青岛出版社",
//    "origin_title" : "",
//    "isbn13" : "9787543632608",
//    "alt_title" : "",
//    "image" : "https:\/\/img3.doubanio.com\/mpic\/s1747553.jpg",
//    "id" : "1220562",
//    "subtitle" : "",
//    "title" : "满月之夜白鲸现",
//    "isbn10" : "7543632608",
//    "images" : {
//        "small" : "https:\/\/img3.doubanio.com\/spic\/s1747553.jpg",
//        "large" : "https:\/\/img3.doubanio.com\/lpic\/s1747553.jpg",
//        "medium" : "https:\/\/img3.doubanio.com\/mpic\/s1747553.jpg"
//    },
//    "pubdate" : "2005-1",
//    "url" : "https:\/\/api.douban.com\/v2\/book\/1220562",
//    "pages" : "180"
//}
