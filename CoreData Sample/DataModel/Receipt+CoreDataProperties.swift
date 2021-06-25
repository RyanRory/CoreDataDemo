//
//  Receipt+CoreDataProperties.swift
//  
//
//  Created by Ryan ZHAO on 23/6/21.
//
//

import Foundation
import CoreData


extension Receipt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    @NSManaged public var active: Bool
    @NSManaged public var created: Date?
    @NSManaged public var id: Int64
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var lastUpdatedUserEntityId: Int64
    @NSManaged public var productItemId: Int64
    @NSManaged public var receivedQuantity: Int64
    @NSManaged public var sentDate: Date?
    @NSManaged public var transientIdentifier: String?

}
