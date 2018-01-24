//
// Created by 刘庆文 on 1-24.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import Foundation
import UIKit

enum JSONError:Error
{
    case InvalidateJSONData
    case NOSuchKeyError(String)
    case InvalidateURL
}

enum RequestResult:Error
{
    case Success([DataItem])
    case Failure(Error)
}

enum Method:String
{
    case GetRecent = "flickr.photos.getRecent"
    case GetPopular = "flickr.photos.getPopular"
    case Search = "flickr.photos.search"
}

struct FlickrAPI
{
    internal static let BASE_URL_STRING = "https://api.flickr.com/services/rest"
    internal static let API_KEY = "3dcf207a59888350611c41dbb5dc04d1"
    
    internal static func fetchImage(with item:DataItem, use session:URLSession, completion:@escaping (String, UIImage)->Void)
    {
        if let url = URL(string: item.urlThumb) {
            let request = URLRequest(url: url)
            session.dataTask(with: request) { data, response, error in
                if
                        let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil,
                        let data = data, let image = UIImage(data: data) {
                    item.imageProfile = image
                    completion(item.id, image)
                }
            }.resume()
        }
    }
    
    internal static func getURL(with method:Method, additional parameters:[String:String]?) -> URL?
    {
        if var url = URLComponents(string: FlickrAPI.BASE_URL_STRING) {
            var queryItems = [URLQueryItem(name: "method", value: method.rawValue), URLQueryItem(name: "api_key", value: FlickrAPI.API_KEY)]
            if let parameters = parameters {
                for (key,value) in parameters {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
            }
            url.queryItems = queryItems
            return url.url
        }
        return nil
    }
    
    internal static func fetchItems(use session:URLSession, with url:URL?, _ completion: @escaping (RequestResult)->Void)
    {
        guard let url = url else {
            completion(.Failure(JSONError.InvalidateURL))
            return
        }
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let jsonData = data else {
                if let error = error {
                    completion(.Failure(error))
                }else {
                    completion(.Failure(JSONError.InvalidateJSONData))
                }
                return
            }
            do {
                let items = try FlickrAPI.parseJson(json: jsonData, keys: ["id", "title", "url_sq", "url_s", "datetaken"])
                var photos = [DataItem]()
                items.forEach { photo in
                    photos.append(DataItem(id: photo["id"]!, title: photo["title"]!, urlImage: photo["url_sq"]!, urlThumb: photo["url_s"]!, dateTaken: photo["datetaken"]!))
                }
                completion(.Success(photos))
            }catch {
                completion(.Failure(error))
            }
        }.resume()
    }
    
    private static func parseJson(json data:Data, keys:[String]) throws -> [[String:String]]
    {
        let jsonObject:AnyObject = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
        guard let jsonDictionary = jsonObject as? [String:AnyObject],
              let jsonPhotos = jsonDictionary["photos"] as? [String:AnyObject],
              let jsonPhoto = jsonPhotos["photo"] as? [[String:AnyObject]] else {
            throw JSONError.InvalidateJSONData
        }
        var items = [[String:String]]()
        try jsonPhoto.forEach { photo in
            var item = [String:String]()
            for key in keys {
                guard let value = photo[key] as? String else {
                    throw JSONError.NOSuchKeyError(key)
                }
                item[key] = value
            }
            items.append(item)
        }
        return items
    }
}
