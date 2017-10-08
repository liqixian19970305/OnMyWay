//
//  MapViewController.swift
//  OnMyWay
//
//  Created by Tony Li on 10/7/17.
//  Copyright © 2017 Tony Li. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    private var orders = OrderCollection() {
        didSet {
            print(orders)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ID: String = orders.addOrder(location: "Berkeley", item: "Chicken")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
