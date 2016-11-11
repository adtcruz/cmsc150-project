//
//  ViewController.swift
//  Ultimate Optimiser
//
//  Created by Anton Dominique Cruz on 10/11/2016.
//  Copyright © 2016 adtcruz. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var actionSelect: NSPopUpButton!
    @IBOutlet var objectiveText: NSTextField!
    @IBOutlet var restraintsText: NSTextField!
    
    
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
    
    @IBAction func standardSolveClicked(_ sender: Any) {
        //let myPopup: NSAlert = NSAlert()
        //myPopup.messageText = "Values"
        //myPopup.informativeText = "Objective function: \(objectiveText.stringValue)\nAction: \(actionSelect.indexOfSelectedItem)\nRestraints: \(restraintsText.stringValue)"
        //myPopup.alertStyle = NSAlertStyle.warning
        //myPopup.runModal()
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

