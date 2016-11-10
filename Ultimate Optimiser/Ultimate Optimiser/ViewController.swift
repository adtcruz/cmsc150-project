//
//  ViewController.swift
//  Ultimate Optimiser
//
//  Created by Anton Dominique Cruz on 10/11/2016.
//  Copyright © 2016 adtcruz. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBAction func standardOClicked(_ sender: Any) {
        performSegue(withIdentifier: "StandardOSegue", sender: self)
        self.view.window?.close()
    }
    
    @IBAction func dietOClicked(_ sender: Any) {
    }
    
    @IBAction func quitBClicked(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "BackToMainSegue", sender: self)
        self.view.window?.close()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

