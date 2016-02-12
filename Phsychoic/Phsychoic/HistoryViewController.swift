//
//  HistoryViewController.swift
//  Phsychoic
//
//  Created by abdelrahman mohamed on 2/7/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    
    var historyDetails: String = "" {
        didSet{
            historyTextView?.text = historyDetails
        }
    }

    @IBOutlet weak var historyTextView: UITextView!{
        didSet{
            historyTextView.text = "\(historyDetails)"
        }
    }
    override var preferredContentSize: CGSize {
        get{
            if historyTextView != nil && presentingViewController != nil {
                return historyTextView.sizeThatFits(presentingViewController!.view.bounds.size)
            }
            return super.preferredContentSize
        }
        set{super.preferredContentSize = newValue}
    }
}
