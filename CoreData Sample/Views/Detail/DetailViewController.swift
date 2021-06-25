//
//  DetailViewController.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 22/6/21.
//

import UIKit
import PureLayout

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    var purchaseOrder: PurchaseOrder?
    var items: Array<Item>? {
        return purchaseOrder?.items?.allObjects as? Array<Item>
    }
    var invoices: Array<Invoice>? {
        return purchaseOrder?.invoices?.allObjects as? Array<Invoice>
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        view.backgroundColor = .white
        initTableView()
        initNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: NSNotification.Name(rawValue: "newItemAdded") , object: nil)
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
        let barButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.createNewItem))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func reloadData(notification: NSNotification?) {
        tableView?.reloadData()
    }
    
    @objc func createNewItem(_: Any) {
        let vc = NewItemViewController()
        vc.purchaseOrder = purchaseOrder
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? items?.count ?? 0 : invoices?.count ?? 0
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Items" : "Invoices"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailItemTableViewCell.identifier) as? DetailItemTableViewCell ?? DetailItemTableViewCell(style: .default, reuseIdentifier: DetailItemTableViewCell.identifier)
            cell.selectionStyle = .none
            cell.setItem(orderItem: items?[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailInvoiceTableViewCell.identifier) as? DetailInvoiceTableViewCell ?? DetailInvoiceTableViewCell(style: .default, reuseIdentifier: DetailInvoiceTableViewCell.identifier)
            cell.selectionStyle = .none
            cell.setInvoice(orderInvoice: invoices?[indexPath.row])
            return cell
        }
    }

}
