//
//  PurchaseOrder+CoreDataProperties.swift
//  
//
//  Created by Ryan ZHAO on 23/6/21.
//
//

import Foundation
import CoreData


extension PurchaseOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchaseOrder> {
        return NSFetchRequest<PurchaseOrder>(entityName: "PurchaseOrder")
    }

    @NSManaged public var active: Bool
    @NSManaged public var approvalStatus: Int16
    @NSManaged public var deliveryNote: String?
    @NSManaged public var id: Int64
    @NSManaged public var issueDate: Date?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var lastUpdatedUserEntityId: Int64
    @NSManaged public var preferredDeliveryDate: Date?
    @NSManaged public var purchaseOrderNumber: String?
    @NSManaged public var sentDate: Date?
    @NSManaged public var status: Int16
    @NSManaged public var supplierId: Int64
    @NSManaged public var invoices: NSSet?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for invoices
extension PurchaseOrder {

    @objc(addInvoicesObject:)
    @NSManaged public func addToInvoices(_ value: Invoice)

    @objc(removeInvoicesObject:)
    @NSManaged public func removeFromInvoices(_ value: Invoice)

    @objc(addInvoices:)
    @NSManaged public func addToInvoices(_ values: NSSet)

    @objc(removeInvoices:)
    @NSManaged public func removeFromInvoices(_ values: NSSet)

}

// MARK: Generated accessors for items
extension PurchaseOrder {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
