//
//  HomeTableViewCell.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 25/6/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    public static let identifier = "HomeTableViewCell"
    var purchaseOrder: PurchaseOrder?
    var orderIdLabel: UILabel?
    var itemNumberLabel: UILabel?
    var lastUpdatedDateLabel: UILabel?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.orderIdLabel = UILabel()
        self.contentView.addSubview(self.orderIdLabel!)
        self.orderIdLabel?.autoPinEdge(toSuperviewMargin: .left, withInset: 8)
        self.orderIdLabel?.autoPinEdge(toSuperviewMargin: .top, withInset: 8)
        
        self.itemNumberLabel = UILabel()
        self.contentView.addSubview(self.itemNumberLabel!)
        self.itemNumberLabel?.autoPinEdge(toSuperviewMargin: .right, withInset: 8)
        self.itemNumberLabel?.autoPinEdge(toSuperviewMargin: .top, withInset: 8)
        
        self.lastUpdatedDateLabel = UILabel()
        self.contentView.addSubview(self.lastUpdatedDateLabel!)
        self.lastUpdatedDateLabel?.autoPinEdge(toSuperviewMargin: .right, withInset: 8)
        self.lastUpdatedDateLabel?.autoPinEdge(toSuperviewMargin: .bottom, withInset: 4)
        self.lastUpdatedDateLabel?.textColor = .gray
        self.lastUpdatedDateLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setOrder(order: PurchaseOrder) {
        purchaseOrder = order
        self.orderIdLabel?.text = "Order ID: \(purchaseOrder?.purchaseOrderNumber ?? "NAN")"
        self.itemNumberLabel?.text = "Item number: \(purchaseOrder?.items?.count ?? 0)"
        self.lastUpdatedDateLabel?.text = "\(purchaseOrder?.lastUpdated?.toString() ?? "NAN")"
    }

}
