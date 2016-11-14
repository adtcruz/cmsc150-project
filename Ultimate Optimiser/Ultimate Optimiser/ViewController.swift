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

        //checks if the input fields are blank
        if(objectiveText.stringValue==""){
            noObjectiveF = true
        }
        if(actionSelect.indexOfSelectedItem==0){
            noAction = true
        }
        if(restraintsText.stringValue==""){
            noRestraints = true
        }

        //sets-up the error messages
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

        //shows the error messages if there were any blank inputs
        if(noObjectiveF || noAction || noRestraints){
            popupAlert.alertStyle = NSAlertStyle.warning
            popupAlert.runModal();
            return
        }

        //checks if the Objective Function matches the pattern
        var rgxmatches = getMatches(in: "^([+-])?[0-9]*(([.][0-9]+)?)[a-z][ ][+][ ](([+-])?[0-9]*(([.][0-9]*)?)[a-z][ ][+][ ])*([+-])?[0-9]*(([.][0-9]*)?)[a-z][ ][=][ ]Z", in: objectiveText.stringValue)
        if(rgxmatches.count == 1){
            print(rgxmatches)
        }
        else{
          //shows an error message if the Objective Function does not match the prescribed pattern
          popupAlert.messageText = "Error encountered!"
          popupAlert.informativeText = "Please check Objective Function. Objective Function should follow the proper format."
          popupAlert.alertStyle = NSAlertStyle.warning
          popupAlert.runModal()
          return
        }
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
