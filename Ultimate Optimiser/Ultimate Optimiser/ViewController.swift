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
        var myPopup: NSAlert = NSAlert()
        if(objectiveText.stringValue==""){
            myPopup.messageText = "Objective function is blank!"
            myPopup.informativeText = "Please enter an objective function."
            myPopup.runModal();
        }
        if(actionSelect.indexOfSelectedItem==0){
            myPopup.messageText = "Action not defined!"
            myPopup.informativeText = "Please select an action."
            myPopup.runModal();
        }
        if(restraintsText.stringValue==""){
            myPopup.messageText = "There are no restraints!"
            myPopup.informativeText = "Please enter restraints."
            myPopup.runModal();
        }
        
        var rgxmatches = getMatches(in: "^([+-])?[0-9]*[a-z]", in: objectiveText.stringValue)
        print(rgxmatches)
        //var strn = objectiveText.stringValue
        //let regex = try! NSRegularExpression(pattern: "^([+-]?[0-9]*)",options:[])
        //var results = regex.matches(in: objectiveText.stringValue, options: [], range: NSMakeRange(0, objectiveText.stringValue.characters.count))
        //print(results.map{strn.substring(with: NSMakeRange(0, objectiveText.stringValue.characters.count))})
        //myPopup.informativeText = ""
        //myPopup.runModal()
        //myPopup.messageText = "Values"
        //myPopup.informativeText = "Objective function: \(objectiveText.stringValue)\nAction: \(actionSelect.indexOfSelectedItem)\nRestraints: \(restraintsText.stringValue)"
        //myPopup.alertStyle = NSAlertStyle.warning
        //myPopup.runModal()
    }
    
    func getMatches(in regex: String, in text: String) -> [String] {
        var regex = try! NSRegularExpression(pattern: regex)
        var strng = text as NSString
        var results = regex.matches(in: text, range: NSRange(location: 0, length: strng.length))
        return results.map { strng.substring(with: $0.range)}
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
