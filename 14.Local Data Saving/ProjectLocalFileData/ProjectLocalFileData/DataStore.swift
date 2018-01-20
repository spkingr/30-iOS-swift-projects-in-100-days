//
// Created by 刘庆文 on 1-20.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//
import Foundation
import UIKit

let FILE_NAME = "project_local_file_data.data"

class DataStore
{
    static var items:[DataItem]!
    
    static func saveData()
    {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            let path = url.appendingPathComponent(FILE_NAME)
            NSKeyedArchiver.archiveRootObject(DataStore.items, toFile: path.path)
        }
    }
    
    static func retrieveData()
    {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            let path = url.appendingPathComponent(FILE_NAME)
            if let items = NSKeyedUnarchiver.unarchiveObject(withFile: path.path) {
                DataStore.items = items as! [DataItem]
                return
            }
        }
        
        //if no data then create new empty array
        DataStore.items = []
    }
    
    static func createNewItem()
    {
        let random = Int(arc4random_uniform(50))
        let item = DataItem(name: "Name\(random)", stars: random, info: "Nothing is here...", birthday: Date())
        DataStore.items.append(item)
        
        print(DataStore.items.count)
    }
}

class DataItem:NSObject, NSCoding
{
    private var uuid:String //for image data store
    
    var name:String
    var stars:Int
    var info:String?
    var birthday:Date
    var profile:UIImage? = nil //nil before retrieving from file
    
    init(name:String, stars:Int, info:String?, birthday:Date)
    {
        self.uuid = UUID().uuidString
        
        self.name = name
        self.stars = stars
        self.info = info
        self.birthday = birthday
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.uuid, forKey: "uuid")
        
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.stars, forKey: "stars")
        aCoder.encode(self.info, forKey: "info")
        aCoder.encode(self.birthday, forKey: "birthday")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.uuid = aDecoder.decodeObject(forKey: "uuid") as! String
        
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.stars = aDecoder.decodeInteger(forKey: "stars")
        self.info = aDecoder.decodeObject(forKey: "info") as! String?
        self.birthday = aDecoder.decodeObject(forKey: "birthday") as! Date
    }
}