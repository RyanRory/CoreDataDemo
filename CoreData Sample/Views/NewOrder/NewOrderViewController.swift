//
//  NewOrderViewController.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 25/6/21.
//

import UIKit

class NewOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    var purchaseOrder: PurchaseOrder?
    var items: Array<Item>? {
        return purchaseOrder?.items?.allObjects as? Array<Item>
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Order"
        view.backgroundColor = .systemGray5
        initTableView()
        initNavBar()
        createNewPurchaseOrder()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: NSNotification.Name(rawValue: "newItemAdded") , object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "newItemAdded"), object: nil)
    }
    
    func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView?.backgroundColor = .systemGray6
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        tableView?.autoPinEdgesToSuperviewEdges()
    }
    
    func initNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.saveOrder))
        self.navigationItem.rightBarButtonItem = doneButton
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func createNewPurchaseOrder() {
        if let context = CoreDataHelper.shared.getCoreDataContext() {
            purchaseOrder = PurchaseOrder(context: context)
            purchaseOrder?.purchaseOrderNumber = "New Local Order"
            purchaseOrder?.lastUpdated = Date()
        }
    }
    
    @objc func reloadData(notification: NSNotification?) {
        tableView?.reloadData()
    }
    
    @objc func addNewItems(_: Any) {
        let vc = NewItemViewController()
        vc.purchaseOrder = purchaseOrder
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @objc func saveOrder(_: Any) {
        if let count = items?.count, count > 0 {
            self.dismiss(animated: true, completion: nil)
            CoreDataHelper.shared.saveCoreDataContext()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "purchaseOrdersUpdated"), object: nil)
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController.init(title: nil, message: "Please add items.", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func cancel(_: Any) {
        CoreDataHelper.shared.deleteFromContext(obj: purchaseOrder)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "purchaseOrdersUpdated"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let addItemsButton = UIButton(type: .system)
        addItemsButton.addTarget(self, action: #selector(self.addNewItems), for: .touchUpInside)
        addItemsButton.setTitle("Add New Item", for: .normal)
        return addItemsButton
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailItemTableViewCell.identifier) as? DetailItemTableViewCell ?? DetailItemTableViewCell(style: .default, reuseIdentifier: DetailItemTableViewCell.identifier)
        cell.selectionStyle = .none
        cell.setItem(orderItem: items?[indexPath.row])
        return cell
    }

}
