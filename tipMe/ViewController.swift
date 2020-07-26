//
//  ViewController.swift
//  tipMe
//
//  Created by Henry Rivera on 7/25/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var sizeField: UITextField!
    
    @IBOutlet weak var splitCost: UILabel!
    
    var totalBill = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTap(_ sender: Any) {
        // print("Hello")
        view.endEditing(true)
    }
    
    @IBAction func calcTip(_ sender: Any) {
        // Get bill amount
        let bill = Double(billField.text!) ?? 0
        
        // Calc tip and total
        let percentages = [0.15, 0.18, 0.20]
        let tip = bill * percentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        totalBill = total
        
        // Update tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    @IBAction func calcSplit(_ sender: Any) {
        // Get amount of people
        let groupSize = Double(sizeField.text!) ?? 0
        
        // Calculate split
        let split = totalBill / groupSize
        
        // Update member owes label
        if split.isFinite {
            splitCost.text = String(format: "$%.2f", split)
        }
        else{
            splitCost.text = "$0.00"
        }
    }
}

