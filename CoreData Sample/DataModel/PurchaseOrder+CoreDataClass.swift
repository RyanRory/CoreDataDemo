//
//  PurchaseOrder+CoreDataClass.swift
//  
//
//  Created by Ryan ZHAO on 23/6/21.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(PurchaseOrder)
public class PurchaseOrder: NSManagedObject {
    func setAttributes(from json: JSON) {
        id = json["id"].int64Value
        supplierId = json["supplier_id"].int64Value
        purchaseOrderNumber = json["purchase_order_number"].stringValue
        issueDate = json["issue_date"].stringValue.toDate()
        status = json["status"].int16Value
        active = json["active_flag"].boolValue
        lastUpdated = json["last_updated"].stringValue.toDate()
        lastUpdatedUserEntityId = json["last_updated_user_entity_id"].int64Value
        sentDate = json["sent_date"].stringValue.toDate()
        approvalStatus = json["approval_status"].int16Value
        preferredDeliveryDate = json["preferred_delivery_date"].stringValue.toDate()
        deliveryNote = json["delivery_note"].stringValue
    }
    
    func updateIfNeeded(from json: JSON, context: NSManagedObjectContext) -> Bool {
        guard let lastUpdated = json["last_updated"].stringValue.toDate(), lastUpdated > self.lastUpdated! else {
            return false
        }
        setAttributes(from: json)
        json["items"].arrayValue.forEach{ itemJSON in
            let id = itemJSON["id"].int64Value
            if let item = Item.getItem(with: id, context: context) {
                let _ = item.updateIfNeeded(from: itemJSON)
            } else {
                let item = Item.createItem(from: itemJSON, context: context)
                addToItems(item)
            }
        }
        json["invoices"].arrayValue.forEach{ invoiceJSON in
            let id = invoiceJSON["id"].int64Value
            if let invoice = Invoice.getInvoice(with: id, context: context) {
                let _ = invoice.updateIfNeeded(from: invoiceJSON, context: context)
            } else {
                let invoice = Invoice.createInvoice(from: invoiceJSON, context: context)
                addToInvoices(invoice)
            }
        }
        return true
    }
}

extension PurchaseOrder {
    public static func getPurchaseOrder(with id: Int64, context: NSManagedObjectContext) -> PurchaseOrder? {
        let request: NSFetchRequest<PurchaseOrder> = PurchaseOrder.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        if let result = try? context.fetch(request), result.count > 0 {
            return result.first
        }
        return nil
    }
    
    public static func createPurchaseOrder(from json: JSON, context: NSManagedObjectContext) -> PurchaseOrder {
        let purchaseOrder = PurchaseOrder(context: context)
        purchaseOrder.setAttributes(from: json)
        json["items"].arrayValue.forEach{ itemJSON in
            let item = Item.createItem(from: itemJSON, context: context)
            purchaseOrder.addToItems(item)
        }
        json["invoices"].arrayValue.forEach{ invoiceJSON in
            let invoice = Invoice.createInvoice(from: invoiceJSON, context: context)
            purchaseOrder.addToInvoices(invoice)
        }
        return purchaseOrder
    }
}
