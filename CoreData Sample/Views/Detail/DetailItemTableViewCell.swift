//
//  DetailItemTableViewCell.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 25/6/21.
//

import UIKit

class DetailItemTableViewCell: UITableViewCell {
    
    public static let identifier = "DetailItemTableViewCell"
    var item: Item?
    var itemIdLabel: UILabel?
    var itemQuantityLabel: UILabel?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.itemIdLabel = UILabel()
        self.contentView.addSubview(self.itemIdLabel!)
        self.itemIdLabel?.autoPinEdge(toSuperviewMargin: .left, withInset: 6)
        self.itemIdLabel?.autoPinEdge(toSuperviewMargin: .top, withInset: 6)
        
        self.itemQuantityLabel = UILabel()
        self.contentView.addSubview(self.itemQuantityLabel!)
        self.itemQuantityLabel?.autoPinEdge(toSuperviewMargin: .left, withInset: 6)
        self.itemQuantityLabel?.autoPinEdge(toSuperviewMargin: .bottom, withInset: 6)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItem(orderItem: Item?) {
        item = orderItem
        self.itemIdLabel?.text = "Item ID: \(item?.productItemId ?? -1)"
        self.itemQuantityLabel?.text = "Item Quantity: \(item?.quantity ?? 0)"
    }

}
