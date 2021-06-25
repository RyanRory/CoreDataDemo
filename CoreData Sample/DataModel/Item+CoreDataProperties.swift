//
//  Item+CoreDataProperties.swift
//  
//
//  Created by Ryan ZHAO on 23/6/21.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var active: Bool
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var lastUpdatedUserEntityId: Int64
    @NSManaged public var quantity: Int64
    @NSManaged public var transientIdentifier: String?
    @NSManaged public var id: Int64
    @NSManaged public var productItemId: Int64

}
