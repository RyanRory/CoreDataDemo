//
//  NewItemViewController.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 25/6/21.
//

import UIKit

class NewItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    var purchaseOrder: PurchaseOrder?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Item"
        view.backgroundColor = .systemGray5
        initTableView()
        initNavBar()
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
    
    @objc func saveOrder(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
