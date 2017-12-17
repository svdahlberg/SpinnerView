//
//  ViewController.swift
//  SpinnerView
//
//  Created by svdahlberg on 12/16/2017.
//  Copyright (c) 2017 svdahlberg. All rights reserved.
//

import UIKit
import SpinnerView

class ViewController: UIViewController {

    @IBOutlet private weak var spinnerView: SpinnerView!
    
    @IBAction private func start(_ sender: Any) {
        spinnerView.start()
    }
    
    @IBAction private func stop(_ sender: Any) {
        spinnerView.stop(success: true)
    }
    
}
