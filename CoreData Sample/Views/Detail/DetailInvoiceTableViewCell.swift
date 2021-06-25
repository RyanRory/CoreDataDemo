//
//  DetailInvoiceTableViewCell.swift
//  CoreData Sample
//
//  Created by Ryan ZHAO on 25/6/21.
//

import UIKit

class DetailInvoiceTableViewCell: UITableViewCell {
    
    public static let identifier = "DetailInvoiceTableViewCell"
    var invoice: Invoice?
    var invoiceIdLabel: UILabel?
    var receivedStatusLabel: UILabel?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.invoiceIdLabel = UILabel()
        self.contentView.addSubview(self.invoiceIdLabel!)
        self.invoiceIdLabel?.autoPinEdge(toSuperviewMargin: .left, withInset: 6)
        self.invoiceIdLabel?.autoPinEdge(toSuperviewMargin: .top, withInset: 6)
        
        self.receivedStatusLabel = UILabel()
        self.contentView.addSubview(self.receivedStatusLabel!)
        self.receivedStatusLabel?.autoPinEdge(toSuperviewMargin: .left, withInset: 6)
        self.receivedStatusLabel?.autoPinEdge(toSuperviewMargin: .bottom, withInset: 6)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInvoice(orderInvoice: Invoice?) {
        invoice = orderInvoice
        self.invoiceIdLabel?.text = "Invoice ID: \(invoice?.invoiceNumber ?? "NAN")"
        self.receivedStatusLabel?.text = "Received Status: \(invoice?.receivedStatus ?? -1)"
    }

}
