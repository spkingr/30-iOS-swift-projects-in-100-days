//
// Created by 刘庆文 on 1-23.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import Foundation
import UIKit

internal let DEFAULT_IMAGE_NAME = "photoalbum"

enum ImageType
{
    case Profile
    case Source
}

class Photo: NSObject
{
    
    var id:String
    var title:String
    var urlThumb:String
    var urlImage:String
    var dateTaken:String
    
    let keyProfile:NSString
    let keySource:NSString
    
    init(id:String, title:String, urlThumb:String, urlImage:String, dateTaken:String)
    {
        self.id = id
        self.title = title
        self.urlThumb = urlThumb
        self.urlImage = urlImage
        self.dateTaken = dateTaken
        
        self.keyProfile = NSString(string: urlThumb)
        self.keySource = NSString(string: urlImage)
        
        super.init()
    }
}

class PhotoStore
{
    var data = [ Photo ]()
    
    private let imageCache = NSCache<NSString, UIImage>()
    private let urlSession:URLSession = {
        return URLSession(configuration: .default)
    }()
    
    func saveImage(_ image:UIImage, with photo:Photo) -> (Bool, String?)
    {
        let fileName = "\(photo.id).jpg"
        if var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            url.appendPathComponent(fileName, isDirectory: false)
            if let data = UIImageJPEGRepresentation(image, 0.5) {
                do {
                    try data.write(to: url, options: [Data.WritingOptions.atomic])
                    return (true, fileName)
                } catch {
                    return (false, nil)
                }
            }
        }
        return (false, nil)
    }
    
    func deleteCache()
    {
        self.imageCache.removeAllObjects()
    }
    
    func loadData(_ completion:@escaping (Bool, Error?) -> Void)
    {
        let url = FlickrAPI.recentPhotoURL(additional: ["extras":"url_sq,url_m,geo,date_taken", "format":"json", "nojsoncallback":"1", "per_page":"20", "page":"1"])
        FlickrAPI.fetchItems(use: self.urlSession, with: url, for: ["id", "title", "url_sq", "url_m", "datetaken"]) { thread, result in
            let success:Bool!
            var error:Error? = nil
            
            switch result {
                case .Failure(let e):
                    success = false
                    error = e
                case .Success(let items):
                    self.data.removeAll()
                    items.forEach { photo in
                        self.data.append(Photo(id: photo["id"]!, title: photo["title"]!, urlThumb: photo["url_sq"]!, urlImage: photo["url_m"]!, dateTaken: photo["datetaken"]!))
                    }
                    success = true
            }
            
            switch thread {
                case .Main:
                    completion(success, error)
                case .Thread:
                    DispatchQueue.main.async {
                        completion(success, error)
                    }
            }
        }
    }
    
    func loadImage(item: Photo, type: ImageType , _ completion:@escaping (UIImage?)->Void)
    {
        let url:String!
        let key:NSString!
        switch type {
            case .Profile:
                url = item.urlThumb
                key = item.keyProfile
            case .Source:
                url = item.urlImage
                key = item.keySource
        }
        
        if let image = self.getImage(key: key) {
            completion(image)
            return
        }
        
        FlickrAPI.fetchImage(with: url, use: self.urlSession) {thread, image in
            
            if let image = image {
                self.saveImage(key: key, value: image)
            }
            
            switch thread {
                case .Main:
                    completion(image)
                case .Thread:
                    DispatchQueue.main.async{
                        completion(image)
                    }
            }
        }
    }
    
    private func saveImage(key:NSString, value:UIImage)
    {
        self.imageCache.setObject(value, forKey: key)
    }
    
    private func getImage(key:NSString) -> UIImage?
    {
        return self.imageCache.object(forKey: key)
    }
}