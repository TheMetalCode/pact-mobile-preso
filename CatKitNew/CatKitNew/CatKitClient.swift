//
//  CatKitClient.swift
//  CatKitNew
//
//  Created by Jason Hagglund on 10/12/18.
//  Copyright © 2018 TheMetalCode. All rights reserved.
//

import Foundation
import Alamofire

public class CatKitClient {
    private let baseUrl: String
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public func feedMe(feedMeResponse: @escaping (String, String) -> Void) {
        let headers = [
            "Accept": "application/json"
        ]
        
        Alamofire.request("\(baseUrl)/feed-me", method: .get, headers: headers).responseJSON { (result) in
            if let json = result.result.value as? Dictionary<String, String> {
                feedMeResponse(json["message"]!, json["status"]!)
            }
        }
    }
}
