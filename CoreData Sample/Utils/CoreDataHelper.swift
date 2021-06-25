//
//  CoreDataHelper.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 23/6/21.
//

import Foundation
import SwiftyJSON
import CoreData
import PromiseKit

public class CoreDataHelper {
    
    // MARK: Initialization
    public static let shared = CoreDataHelper()
    
    // MARK: Error
    public enum Error : LocalizedError {
        case generic
        case noContext

        public var errorDescription: String? {
            switch self {
            case .generic: return "An error occurred."
            case .noContext: return "Failed to get the context."
            }
        }
    }
    
    // MARK: Main
    func getCoreDataContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    func getPurchaseOrders() -> Promise<[PurchaseOrder]> {
        let (promise, seal) = Promise<[PurchaseOrder]>.pending()
        if let context = getCoreDataContext() {
            do {
                let request: NSFetchRequest<PurchaseOrder> = PurchaseOrder.fetchRequest()
                let purchaseOrders = try context.fetch(request)
                seal.fulfill(purchaseOrders)
            } catch let error as NSError {
                seal.reject(error)
            }
        } else {
            seal.reject(Error.noContext)
        }
        return promise
    }
    
    func syncFromServerIfNeeded(json: JSON) -> Promise<Bool> {
        let (promise, seal) = Promise<Bool>.pending()
        var updated = false
        if let context = getCoreDataContext() {
            json.arrayValue.forEach { purchaseOrderJSON in
                let id = purchaseOrderJSON["id"].int64Value
                if let purchaseOrder = PurchaseOrder.getPurchaseOrder(with: id, context: context) {
                    updated = purchaseOrder.updateIfNeeded(from: purchaseOrderJSON, context: context)
                } else {
                    let _ = PurchaseOrder.createPurchaseOrder(from: purchaseOrderJSON, context: context)
                    updated = true
                }
            }
            do {
                try context.save()
            } catch let error as NSError {
                seal.reject(error)
            }
            seal.fulfill(updated)
        } else {
            seal.reject(Error.noContext)
        }
        return promise
    }
}
