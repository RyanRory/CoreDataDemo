//
//  Invoice+CoreDataClass.swift
//  
//
//  Created by Ryan ZHAO on 23/6/21.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Invoice)
public class Invoice: NSManagedObject {
    func setAttributes(from json: JSON) {
        id = json["id"].int64Value
        invoiceNumber = json["invoice_number"].string
        receivedStatus = json["received_status"].int16Value
        created = json["created"].stringValue.toDate()
        lastUpdatedUserEntityId = json["last_updated_user_entity_id"].int64Value
        transientIdentifier = json["transient_identifier"].string
        active = json["active_flag"].boolValue
        receiptSentDate = json["receipt_sent_date"].stringValue.toDate()
        lastUpdated = json["last_updated"].stringValue.toDate()
    }
    
    func updateIfNeeded(from json: JSON, context: NSManagedObjectContext) -> Bool {
        guard let lastUpdated = json["last_updated"].stringValue.toDate(), lastUpdated > self.lastUpdated! else {
            return false
        }
        setAttributes(from: json)
        json["receipts"].arrayValue.forEach{ receiptJSON in
            let id = receiptJSON["id"].int64Value
            if let receipt = Receipt.getReceipt(with: id, context: context) {
                let _ = receipt.updateIfNeeded(from: receiptJSON)
            } else {
                let receipt = Receipt.createReceipt(from: receiptJSON, context: context)
                addToReceipts(receipt)
            }
        }
        return true
    }
}

extension Invoice{
    public static func getInvoice(with id: Int64, context: NSManagedObjectContext) -> Invoice? {
        let request: NSFetchRequest<Invoice> = Invoice.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        if let result = try? context.fetch(request), result.count > 0 {
            return result.first
        }
        return nil
    }
    
    public static func createInvoice(from json: JSON, context: NSManagedObjectContext) -> Invoice {
        let invoice = Invoice(context: context)
        invoice.setAttributes(from: json)
        json["receipts"].arrayValue.forEach{ receiptJSON in
            let receipt = Receipt.createReceipt(from: receiptJSON, context: context)
            invoice.addToReceipts(receipt)
        }
        return invoice
    }
}

