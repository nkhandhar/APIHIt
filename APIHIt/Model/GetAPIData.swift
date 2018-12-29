//
//  GetAPIData.swift
//  APIHIt
//
//  Created by Macbook Pro on 29/12/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class GetAPIData: NSObject {

    var finalPage :Int!
    var currentPage:Int!
    var postArray:[PostData] = []
    
    init(dictionary: [String: Any]) {
        currentPage = dictionary["page"] as? Int
        finalPage = dictionary["nbPages"] as? Int
        
        if let hitArray = dictionary["hits"] as? [[String:Any]] {
            for i in hitArray{
                postArray.append(PostData(dictionary: i))
            }
        }
        
    }
    
}

class PostData: NSObject {
    var strGetTitle:String!
    var strGetCreatedAt:String
    
    init(dictionary: [String: Any]) {
        
        strGetTitle = dictionary["title"] as? String ?? ""
        strGetCreatedAt = dictionary["created_at"] as? String ?? ""
       
    }
}
