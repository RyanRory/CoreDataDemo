//
//  Item+CoreDataClass.swift
//  
//
//  Created by Ryan ZHAO on 23/6/21.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Item)
public class Item: NSManagedObject {
    func setAttributes(from json: JSON) {
        id = json["id"].int64Value
        productItemId = json["product_item_id"].int64Value
        quantity = json["quantity"].int64Value
        lastUpdatedUserEntityId = json["last_updated_user_entity_id"].int64Value
        transientIdentifier = json["transient_identifier"].string
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

extension Item {
    public static func getItem(with id: Int64, context: NSManagedObjectContext) -> Item? {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        if let result = try? context.fetch(request), result.count > 0 {
            return result.first
        }
        return nil
    }
    
    public static func createItem(from json: JSON, context: NSManagedObjectContext) -> Item {
        let item = Item(context: context)
        item.setAttributes(from: json)
        return item
    }
}
