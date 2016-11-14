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
        var popupAlert: NSAlert = NSAlert()
        var noAction:Bool = false
        var noObjectiveF:Bool = false
        var noRestraints:Bool = false

        if(objectiveText.stringValue==""){
            noObjectiveF = true
        }
        if(actionSelect.indexOfSelectedItem==0){
            noAction = true
        }
        if(restraintsText.stringValue==""){
            noRestraints = true
        }

        if(noObjectiveF){
            popupAlert.messageText = "Error encountered!"
            popupAlert.informativeText = "No Objective Function. Please enter an Objective Function."
        }

        if(noAction){
            if(popupAlert.informativeText == ""){
                popupAlert.messageText = "Error encountered!"
                popupAlert.informativeText = "No action selected. Please select either 'Maximise' or 'Minimise'."
            }
            else{
                popupAlert.messageText = "Errors encountered!"
                popupAlert.informativeText = popupAlert.informativeText + "\nNo action selected. Please select either 'Maximise' or 'Minimise'."
            }
        }

        if(noRestraints){
          if(popupAlert.informativeText == ""){
              popupAlert.messageText = "Error encountered!"
              popupAlert.informativeText = "No Restraints. Please enter Restraints. Restraints are separated by lines."
          }
          else{
              popupAlert.messageText = "Errors encountered!"
              popupAlert.informativeText = popupAlert.informativeText + "\nNo Restraints. Please enter Restraints. Restraints are separated by lines."
          }
        }

        if(noObjectiveF || noAction || noRestraints){
            popupAlert.runModal();
            return
        }

        var rgxmatches = getMatches(in: "^([+-])?[0-9]*(([.][0-9]+)?)[a-z][ ][+][ ](([+-])?[0-9]*(([.][0-9]*)?)[a-z][ ][+][ ])*([+-])?[0-9]*(([.][0-9]*)?)[a-z][ ][=][ ]Z", in: objectiveText.stringValue)
        if(rgxmatches.count > 0){
            print(rgxmatches)
        }
        else{
          popupAlert.messageText = "Error encountered!"
          popupAlert.informativeText = "Please check Objective Function. Objective Function should follow the proper format."
          popupAlert.runModal()
          return
        }
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func getMatches(in regexPattern: String, in text: String) -> [String] {
        var regex = try! NSRegularExpression(pattern: regexPattern)
        var strng = text as NSString
        var results = regex.matches(in: text, range: NSRange(location: 0, length: strng.length))
        return results.map { strng.substring(with: $0.range)}
    }


}
