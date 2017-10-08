//
//  OrderCollection.swift
//  OnMyWay
//
//  Created by Tony Li on 10/7/17.
//  Copyright © 2017 Tony Li. All rights reserved.
//

import Foundation
class OrderCollection {
    var collection = [Dictionary<String, Order>]()
    
    
    init() {
        let currentDictionary = [String: Order]()
        let readyDictionary = [String: Order]()
        let completedDictionary = [String: Order]()
        collection.append(currentDictionary)
        collection.append(readyDictionary)
        collection.append(completedDictionary)
    }
    
    public func getID(ofOrder: Order?) -> String {
        return ofOrder!.ID
    }
    
    public func searchByID(ID: String) -> Order? {
        for index in 0..<collection.count {
            if let order = collection[index][ID] {
                return order
            }
        }
        return nil
    }
    
    public func changeToReady (ID: String) {
        if let collection[0].removeValue(forKey: ID)
    }
    
    public func addOrder(location: String, item: String) -> String {
        let newOrder = Order(location: location, item: item)
        
        /*var testarray = [Dictionary<String, Int>]()
        var array1 = [String: Int]()
        testarray.append(array1)
        testarray[0].updateValue(1, forKey: "123")
        print(testarray[0]["123"])*/
        collection[0].updateValue(newOrder, forKey: newOrder.ID)
        //let aDictionary = collection[0]
        return newOrder.ID
        
    }
}
