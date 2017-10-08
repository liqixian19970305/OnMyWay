//
//  Parser.swift
//  OnMyWay
//
//  Created by Tony Li on 10/8/17.
//  Copyright © 2017 Tony Li. All rights reserved.
//

import Foundation

class Parser {
    var items: [String] = ["French Fries", "Burger", "Noodles", "Coke", "Teriyaki Chicken"]
    var locations: [String] = ["Soda Hall", "Stadium", "University Library"]
    
    func match(transcript: String) -> (String, String) {
        var foundItem: String = ""
        var foundLocation: String = ""
        for item in items {
            if transcript.lowercased().range(of: item.lowercased()) != nil {
                foundItem = item
            }
        }
        for location in locations {
            if transcript.lowercased().range(of: location.lowercased()) != nil {
                foundLocation = location
            }
        }
        return (foundItem, foundLocation)
    }
}
