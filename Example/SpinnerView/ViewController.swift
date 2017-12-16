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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinnerView.start()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTap() {
        spinnerView.isAnimating ? spinnerView.stop(success: true) : spinnerView.start()
    }

}

