//
//  HomeViewController.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 22/6/21.
//

import UIKit
import PureLayout

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    var purchaseOrders: Array<PurchaseOrder> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        initTableView()
        initNavBar()
        self.reloadData(notification: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: NSNotification.Name(rawValue: "didUpdateFromServer") , object: nil)
    }
    
    func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView?.backgroundColor = .systemGray5
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        tableView?.autoPinEdgesToSuperviewEdges()
    }
    
    func initNavBar() {
        let barButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.createNewOrder))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func reloadData(notification: NSNotification?) {
        CoreDataHelper.shared.getPurchaseOrders().done{ orders in
            self.purchaseOrders = orders
            self.tableView?.reloadData()
        }
    }
    
    @objc func createNewOrder(_: Any) {
        let vc = NewOrderViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchaseOrders.count
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell ?? HomeTableViewCell(style: .default, reuseIdentifier: HomeTableViewCell.identifier)
        cell.setOrder(order: purchaseOrders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        detailVC.purchaseOrder = purchaseOrders[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
