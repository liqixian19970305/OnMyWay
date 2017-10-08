//
//  Order.swift
//  OnMyWay
//
//  Created by Tony Li on 10/6/17.
//  Copyright © 2017 Tony Li. All rights reserved.
//

import Foundation
struct Order {
    var ID: String
    var time: Date
    var location: String
    var item: String
    var tips: Double
    var comment: String
    var status: Status
    
    enum Status {
        case pending
        case current
        case ready
        case completed
    }
    init (location: String, item: String, tips: Double = 0, comment: String = "", status: Status = .pending) {
        self.ID = UUID().uuidString
        self.time = Date()
        self.location = location
        self.item = item
        self.tips = tips
        self.comment = comment
        self.status = status
    }
    mutating func changeStatus(newStatus: Status) {
        status = newStatus
    }
}
