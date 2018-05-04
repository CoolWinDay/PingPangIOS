//
//  PP_ForumModel.swift
//  CommonSwift
//
//  Created by LpSun on 2018/4/13.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

class PP_ForumModel: CMJsonModel {
    var board_category_id = ""
    var board_category_name = ""
    var board_category_type = ""
    var board_list: [PP_BoardModel] = []
}
