//
//  MyOrdersTableViewCell.swift
//  OnMyWay
//
//  Created by Tony Li on 10/7/17.
//  Copyright © 2017 Tony Li. All rights reserved.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    var order: Order? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let date = order?.time {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(date)>24*60*60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            dateLabel?.text = formatter.string(from: date)
        } else {
            dateLabel?.text = nil
        }
        
        locationLabel?.text = order?.location
        itemLabel?.text = order?.item
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
