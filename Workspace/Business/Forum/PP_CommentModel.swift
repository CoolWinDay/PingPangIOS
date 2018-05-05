//
//  PP_CommentModel.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/5/5.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_CommentModel: CMJsonModel {
    var icon = ""
    var reply_name = ""
    var userTitle = ""
    var posts_date = ""
    var position = ""
    var reply_content: [PP_ContentModel] = []
    
}
