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
    case Success([[ String:String ]])
    case Failure(Error)
}

enum Thread
{
    case Main
    case Thread
}

enum Method:String
{
    case Recent = "flickr.photos.getRecent"
    case Popular = "flickr.photos.getPopular"
    case Search = "flickr.photos.search"
}

struct FlickrAPI
{
    internal static let BASE_URL_STRING = "https://api.flickr.com/services/rest"
    internal static let API_KEY = "42f2bdb87a29e9850227c697b1063afa"
    
    internal static func fetchImage(with url:String, use session:URLSession, completion:@escaping (Thread, UIImage?) -> Void)
    {
        guard let url = URL(string: url) else {
            completion(.Main, nil)
            return
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {data, response, error in
            if
                    let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil,
                    let data = data, let image = UIImage(data: data) {
                completion(.Thread, image)
            } else {
                completion(.Thread, nil)
            }
        }
        task.resume()
    }
    
    internal static func recentPhotoURL(additional parameters:[String:String]?) -> URL?
    {
        return FlickrAPI.getURL(with: .Recent, additional: parameters)
    }
    
    internal static func fetchItems(use session:URLSession, with url:URL?, for keys:[String] , _ completion: @escaping (Thread, RequestResult)->Void)
    {
        guard let url = url else {
            completion(.Main, .Failure(JSONError.InvalidateURL))
            return
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard let jsonData = data else {
                if let error = error {
                    completion(.Thread, .Failure(error))
                }else {
                    completion(.Thread, .Failure(JSONError.InvalidateJSONData))
                }
                return
            }
            do {
                let items = try FlickrAPI.parseJson(json: jsonData, keys: keys)
                completion(.Thread, .Success(items))
            }catch {
                completion(.Thread, .Failure(error))
            }
        }
        task.resume()
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
    
    private static func getURL(with method:Method, additional parameters:[String:String]?) -> URL?
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
}
