//
// Created by 刘庆文 on 2-7.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import Foundation

class PageData: NSObject
{
    var title: String
    var image: String
    var info: String
    
    init(title: String, image: String, info: String)
    {
        self.title = title
        self.image = image
        self.info = info
        super.init()
    }
}