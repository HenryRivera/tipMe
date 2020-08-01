//  Created by Henry Rivera on 7/25/20.
//  File Name: ViewController.swift
//  Description: Pre-Work assignment Code Path iOS course
//  Copyright © 2020 Henry Rivera. All rights reserved

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate{
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var sizeField: UITextField!
    
    @IBOutlet weak var splitCost: UILabel!
    
//    var totalBill = 0.0
    var memberSplit = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
            case .cancelled:
                print("Message was cancelled")
                dismiss(animated: true, completion: nil)
            case .failed:
                print("Message failed")
                dismiss(animated: true, completion: nil)
            case .sent:
                print("Message was sent")
                dismiss(animated: true, completion: nil)
            default:
            break
        }
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calcTip(_ sender: Any) {
        // Get bill amount
        let bill = Double(billField.text!) ?? 0
        
        // Calc tip and total
        let percentages = [0.15, 0.18, 0.20]
        let tip = bill * percentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
//        totalBill = total
        
        // Update tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        
        // Get amount of people
        let groupSize = Double(sizeField.text!) ?? 0
        
        // Calculate split
        let split = total / groupSize
        memberSplit = split
        
        // Update member owes label
        if split.isFinite {
            splitCost.text = String(format: "$%.2f", split)
        }
        else{
            splitCost.text = "$0.00"
        }
    }
    
    // totalBill is not updated correctly. Updating split totals in calcTip
//    @IBAction func calcSplit(_ sender: Any) {
//        // Get amount of people
//        let groupSize = Double(sizeField.text!) ?? 0
//
//        // Calculate split
//        let split = totalBill / groupSize
//        perMember = split
//        print(String(format: "2. calcSplit $%.2f", totalBill))
//
//        // Update member owes label
//        if split.isFinite {
//            splitCost.text = String(format: "$%.2f", split)
//        }
//        else{
//            splitCost.text = "$0.00"
//        }
//    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let messageVC = MFMessageComposeViewController()
            
        messageVC.body = String(format: "Hey! Your split of the bill came out to $%.2f. I can take Apple Pay. Thanks!", memberSplit)
        messageVC.recipients = []
        messageVC.messageComposeDelegate = self
            
        self.present(messageVC, animated: true, completion: nil)
    }
    
    
}

