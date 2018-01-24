//
// Created by 刘庆文 on 1-23.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import Foundation
import UIKit

class DataItem:NSObject
{
    var id:String
    var title:String
    var urlImage:String
    var urlThumb:String
    var dateTaken:String
    
    var imageProfile:UIImage?
    
    init(id:String, title:String, urlImage:String, urlThumb:String, dateTaken:String)
    {
        self.id = id
        self.title = title
        self.urlImage = urlImage
        self.urlThumb = urlThumb
        self.dateTaken = dateTaken
        
        super.init()
    }
}

class DataStore
{
    var data = [DataItem]()
    
    private let urlSession:URLSession = {
        return URLSession(configuration: .default)
    }()
    
    func loadData(_ completion:@escaping (RequestResult) -> Void)
    {
        let url = FlickrAPI.getURL(with: .GetRecent, additional: ["extras":"url_sq,url_s,geo,date_taken", "format":"json", "nojsoncallback":"1"])
        FlickrAPI.fetchItems(use: self.urlSession, with: url, completion)
    }
    
    func loadImage(item:DataItem, _ completion:@escaping (String, UIImage)->Void)
    {
        FlickrAPI.fetchImage(with: item, use: self.urlSession, completion: completion)
    }
}