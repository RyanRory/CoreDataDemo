//
//  Receipt+CoreDataClass.swift
//  
//
//  Created by Ryan ZHAO on 23/6/21.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Receipt)
public class Receipt: NSManagedObject {
    func setAttributes(from json: JSON) {
        id = json["id"].int64Value
        productItemId = json["product_item_id"].int64Value
        receivedQuantity = json["received_quantity"].int64Value
        lastUpdatedUserEntityId = json["last_updated_user_entity_id"].int64Value
        transientIdentifier = json["transient_identifier"].string
        sentDate = json["sent_date"].stringValue.toDate()
        active = json["active_flag"].boolValue
        lastUpdated = json["last_updated"].stringValue.toDate()
    }
    
    func updateIfNeeded(from json: JSON) -> Bool {
        guard let lastUpdated = json["last_updated"].stringValue.toDate(), lastUpdated > self.lastUpdated! else {
            return false
        }
        setAttributes(from: json)
        return true
    }
}

extension Receipt {
    public static func getReceipt(with id: Int64, context: NSManagedObjectContext) -> Receipt? {
        let request: NSFetchRequest<Receipt> = Receipt.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        if let result = try? context.fetch(request), result.count > 0 {
            return result.first
        }
        return nil
    }
    
    public static func createReceipt(from json: JSON, context: NSManagedObjectContext) -> Receipt {
        let receipt = Receipt(context: context)
        receipt.setAttributes(from: json)
        return receipt
    }
}
