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
        }
    }
    
    @objc func saveOrder(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel(_: Any) {
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailItemTableViewCell.identifier) as? DetailItemTableViewCell ?? DetailItemTableViewCell(style: .default, reuseIdentifier: DetailItemTableViewCell.identifier)
        cell.selectionStyle = .none
        cell.setItem(orderItem: items?[indexPath.row])
        return cell
    }

}
