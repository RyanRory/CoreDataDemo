//
//  NewItemViewController.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 25/6/21.
//

import UIKit
import PureLayout

class NewItemViewController: UIViewController, UITextFieldDelegate {
    
    var purchaseOrder: PurchaseOrder?
    var itemIdTextField: UITextField?
    var itemQuantityTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Item"
        view.backgroundColor = .systemGray5
        initNavBar()
        setupUI()
    }
    
    func initNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.saveOrder))
        self.navigationItem.rightBarButtonItem = doneButton
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func setupUI() {
        itemIdTextField = UITextField()
        itemIdTextField?.delegate = self
        itemIdTextField?.borderStyle = .roundedRect
        itemIdTextField?.placeholder = "Item Product ID"
        itemIdTextField?.returnKeyType = .next
        view.addSubview(itemIdTextField!)
        itemIdTextField?.autoPinEdge(toSuperviewMargin: .top, withInset: 20)
        itemIdTextField?.autoPinEdge(toSuperviewMargin: .left, withInset: 20)
        itemIdTextField?.autoPinEdge(toSuperviewMargin: .right, withInset: 20)
        
        itemIdTextField?.becomeFirstResponder()
        
        itemQuantityTextField = UITextField()
        itemQuantityTextField?.delegate = self
        itemQuantityTextField?.borderStyle = .roundedRect
        itemQuantityTextField?.placeholder = "Item Quantity"
        itemQuantityTextField?.returnKeyType = .done
        view.addSubview(itemQuantityTextField!)
        itemQuantityTextField?.autoPinEdge(toSuperviewMargin: .left, withInset: 20)
        itemQuantityTextField?.autoPinEdge(toSuperviewMargin: .right, withInset: 20)
        itemQuantityTextField?.autoPinEdge(.top, to: .bottom, of: itemIdTextField!, withOffset: 20)
    }
    
    @objc func saveOrder(_: Any) {
        if let productIdString = itemIdTextField?.text, let productId = Int64(productIdString), let quantityString = itemQuantityTextField?.text, let quantity = Int64(quantityString) {
            if let context = CoreDataHelper.shared.getCoreDataContext() {
                let item = Item(context: context)
                item.productItemId = productId
                item.quantity = quantity
                item.lastUpdated = Date()
                purchaseOrder?.addToItems(item)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newItemAdded"), object: nil)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == itemIdTextField) {
            itemQuantityTextField?.becomeFirstResponder()
        }
        return true
    }
}
