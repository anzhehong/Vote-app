//
//  ItemModel.swift
//  VoteVoteVote
//
//  Created by FOWAFOLO on 15/11/16.
//  Copyright © 2015年 Fowafolo. All rights reserved.
//

import Foundation


class ItemModel: NSObject, NSCoding {
    
    var name: String?
    var voteCount: Int?
    
    override init() {
        self.voteCount = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.voteCount = aDecoder.decodeObjectForKey("voteCount") as? Int
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let modelName = self.name {
            aCoder.encodeObject(modelName, forKey: "name")
        }
        if let modelCount = self.voteCount {
            aCoder.encodeObject(modelCount, forKey: "voteCount")
        }
    }
    
    func modelToNSData() -> NSData? {
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
    
    class func NSDataToModel(data: NSData) -> ItemModel {
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as! ItemModel
    }

    
}