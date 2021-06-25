//
//  NewOrderViewController.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 25/6/21.
//

import UIKit

class NewOrderViewController: UIViewController {
    
    var purchaseOrder: PurchaseOrder?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Order"
        view.backgroundColor = .systemGray5
        initNavBar()
        setupUI()
        createNewPurchaseOrder()
    }
    
    func initNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.saveOrder))
        self.navigationItem.rightBarButtonItem = doneButton
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func setupUI() {
        
    }
    
    func createNewPurchaseOrder() {
        if let context = CoreDataHelper.shared.getCoreDataContext() {
            purchaseOrder = PurchaseOrder(context: context)
        }
    }
    
    @objc func saveOrder(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
