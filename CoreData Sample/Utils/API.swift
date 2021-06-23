//
//  API.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 23/6/21.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

public class API{
    
    // MARK: Get Data
    public static func getData() -> Promise<JSON> {
        let url = "https://my-json-server.typicode.com/butterfly-systems/sample-data/purchase_orders"
        let (promise, seal) = Promise<JSON>.pending()
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    seal.fulfill(json)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        return promise
    }
    
}


