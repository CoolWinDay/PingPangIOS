//
//  TopicDetailModel.swift0
//  PingPangWang
//
//  Created by 李鹏 on 2018/5/1.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class TopicDetailModel: CMJsonModel {
    var title = ""
    var hits = ""
    var icon = ""
    var user_nick_name = ""
    var userTitle = ""
    var create_date = ""
    var content: [PP_ContentModel] = []
}
