//
//  Invoice+CoreDataProperties.swift
//  
//
//  Created by Ryan ZHAO on 23/6/21.
//
//

import Foundation
import CoreData


extension Invoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }

    @NSManaged public var active: Bool
    @NSManaged public var created: Date?
    @NSManaged public var id: Int64
    @NSManaged public var invoiceNumber: String?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var lastUpdatedUserEntityId: Int64
    @NSManaged public var receiptSentDate: Date?
    @NSManaged public var receivedStatus: Int16
    @NSManaged public var transientIdentifier: String?
    @NSManaged public var receipts: NSSet?

}

// MARK: Generated accessors for receipts
extension Invoice {

    @objc(addReceiptsObject:)
    @NSManaged public func addToReceipts(_ value: Receipt)

    @objc(removeReceiptsObject:)
    @NSManaged public func removeFromReceipts(_ value: Receipt)

    @objc(addReceipts:)
    @NSManaged public func addToReceipts(_ values: NSSet)

    @objc(removeReceipts:)
    @NSManaged public func removeFromReceipts(_ values: NSSet)

}
