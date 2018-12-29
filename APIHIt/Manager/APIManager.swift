//
//  APIManager.swift
//  APITestProject
//
//  Created by Macbook Pro on 24/12/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import Foundation
import Alamofire


class APIManager {
    
    static let shared: APIManager = {
        
        let instance = APIManager()
        return instance
        
    }()
    
    func showPostAPI(tag: String, page: Int, complition:@escaping(GetAPIData, Bool?, String?)->()){
        
        let url = URLS.searchByTagAPI + "tags=\(tag)&page=\(page)"
        
        Alamofire.request(url, method: .get, parameters: nil, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                print(response.result.value as? [String:Any] ?? "No result")
                var responseObj:GetAPIData!
                if let result = response.result.value as? [String:Any] {
    
                    responseObj = GetAPIData(dictionary: result)
                    complition(responseObj, true, nil)
                }else{
                    complition(GetAPIData(dictionary: [:]), false, "Data Not Found!")
                }
                
    
            case .failure(let error) :
                print(error)
                complition(GetAPIData(dictionary: [:]),false, error.localizedDescription)
                
            }
        }
        
    }
    
}
