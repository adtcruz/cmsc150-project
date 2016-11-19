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

    private var objectiveFunctionValues: [String:Double] = [:]
    private var restraintsValues = Array<[String:Double]>()
    private var tabula: [[Double]] = []

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
            var objectiveFunctionString = objectiveText.stringValue
            while(true){
                var term = getMatches(in: "^([+-])?[0-9]*(([.][0-9]+)?)[a-z]",in: objectiveFunctionString)
                if(term.count == 1){
                    var newPat = "^" + term[0]
                    var whiteSpaceFront = "^[ ]"
                    var plusSpacePat = "^[+][ ]"
                    var finalBitsPat = "^[=][ ][Z]"
                    var regex = try! NSRegularExpression(pattern: newPat)
                    objectiveFunctionString = regex.stringByReplacingMatches(in: objectiveFunctionString, options: [], range: NSMakeRange(0, objectiveFunctionString.characters.count), withTemplate: "")
                    regex = try! NSRegularExpression(pattern:whiteSpaceFront)
                    objectiveFunctionString = regex.stringByReplacingMatches(in: objectiveFunctionString, options: [], range: NSMakeRange(0, objectiveFunctionString.characters.count), withTemplate: "")
                    if(getMatches(in: plusSpacePat,in: objectiveFunctionString).count == 1){
                        regex = try! NSRegularExpression(pattern:plusSpacePat)
                        objectiveFunctionString = regex.stringByReplacingMatches(in: objectiveFunctionString, options: [], range: NSMakeRange(0, objectiveFunctionString.characters.count), withTemplate: "")
                    }
                    else if (getMatches(in: finalBitsPat,in: objectiveFunctionString).count == 1){
                        regex = try! NSRegularExpression(pattern:finalBitsPat)
                        objectiveFunctionString = regex.stringByReplacingMatches(in: objectiveFunctionString, options: [], range: NSMakeRange(0, objectiveFunctionString.characters.count), withTemplate: "")
                    }
                    objectiveFunctionValues[getMatches(in: "[a-z]",in: term[0])[0]] = Double(getMatches(in: "^([+-])?[0-9]*(([.][0-9]+)?)", in: term[0])[0])
                }
                else{
                    if(term.count == 0){
                        break
                    }
                }
            }
            //splits the restraints by line and store them into an array
            var restraintsArray = restraintsText.stringValue.characters.split{$0 == "\n"}.map(String.init)
            //accessing the array
            for restraint in restraintsArray{
              var rrgxmatches = getMatches(in: "^([+-])?[0-9]*(([.][0-9]+)?)[a-z]([ ][+][ ](([+-])?[0-9]*(([.][0-9]*)?)[a-z]))*[ ][<][=][ ]([+-])?[0-9]*(([.][0-9]+)?)", in: restraint)
              if(rrgxmatches.count == 1){
                var restraintsString = restraint
                var newDict:[String:Double] = [:]
                while(true){
                  var term = getMatches(in: "^([+-])?[0-9]*(([.][0-9]+)?)[a-z]",in: restraintsString)
                  if(term.count == 1){
                    var newPat = "^" + term[0]
                    var whiteSpaceFront = "^[ ]"
                    var plusSpacePat = "^[+][ ]"
                    var finalBitsPat = "^[<][=][ ]([+-])?[0-9]*(([.][0-9]+)?)"
                    var regex = try! NSRegularExpression(pattern: newPat)
                    restraintsString = regex.stringByReplacingMatches(in: restraintsString, options: [], range: NSMakeRange(0, restraintsString.characters.count), withTemplate: "")
                    regex = try! NSRegularExpression(pattern:whiteSpaceFront)
                    restraintsString = regex.stringByReplacingMatches(in: restraintsString, options: [], range: NSMakeRange(0, restraintsString.characters.count), withTemplate: "")
                    
                    //checks if the term's variable exists in the objective function
                    if(objectiveFunctionValues[getMatches(in: "[a-z]",in: term[0])[0]] == nil){
                        popupAlert.messageText = "Error encountered!"
                        popupAlert.informativeText = "Variable \(getMatches(in: "[a-z]",in: term[0])[0]) is not in the Objective Function."
                        popupAlert.alertStyle = NSAlertStyle.warning
                        popupAlert.runModal()
                        return
                    }
                    
                    newDict[getMatches(in: "[a-z]",in: term[0])[0]] = Double(getMatches(in: "^([+-])?[0-9]*(([.][0-9]+)?)", in: term[0])[0])
                    if(getMatches(in: plusSpacePat,in: restraintsString).count == 1){
                          regex = try! NSRegularExpression(pattern:plusSpacePat)
                          restraintsString = regex.stringByReplacingMatches(in: restraintsString, options: [], range: NSMakeRange(0, restraintsString.characters.count), withTemplate: "")
                      }
                      else if (getMatches(in: finalBitsPat,in: restraintsString).count == 1){
                          regex = try! NSRegularExpression(pattern:"^[<][=][ ]")
                          restraintsString = regex.stringByReplacingMatches(in: restraintsString, options: [], range: NSMakeRange(0, restraintsString.characters.count), withTemplate: "")
                          newDict["RHS"] = Double(getMatches(in: "^([+-])?[0-9]*(([.][0-9]+)?)", in: restraintsString)[0])
                          restraintsValues.append(newDict)
                          regex = try! NSRegularExpression(pattern:finalBitsPat)
                          restraintsString = regex.stringByReplacingMatches(in: restraintsString, options: [], range: NSMakeRange(0, restraintsString.characters.count), withTemplate: "")
                      }
                  }
                  else{
                    if(term.count == 0){
                        break
                    }
                  }
                }
              }
              else if (rrgxmatches.count == 0){
                popupAlert.messageText = "Error encountered!"
                popupAlert.informativeText = "Please check Restraints. Restraints should follow the proper format."
                popupAlert.alertStyle = NSAlertStyle.warning
                popupAlert.runModal()
                return
              }
            }
            
            tabula = [[Double]](repeating: [Double](repeating: 0, count: restraintsValues.count + objectiveFunctionValues.count + 2), count: restraintsValues.count + 1)
            
            ///*
            //adds the RHS values to the tabula
            var i = 0
            for element in restraintsValues{
                tabula[i][tabula[0].count-1] = element["RHS"]!
                i = i + 1
            }
            //adds the restraints values to the tabula
            var j = 0
            i = 0
            for element in restraintsValues{
                j = 0
                for varK in objectiveFunctionValues.sorted(by: { $0.0 < $1.0 }){
                    if(element[varK.0] != nil){
                        tabula[i][j] = element[varK.0]!
                    }
                    j = j + 1
                }
                i = i + 1
            }
            //adds the objective function values to the tabula
            j = 0
            for varK in objectiveFunctionValues.sorted(by: { $0.0 < $1.0 }){
                if(actionSelect.indexOfSelectedItem==2){
                    tabula[tabula.count - 1][j] = varK.1
                }
                else{
                    tabula[tabula.count - 1][j] = (0-varK.1)
                }
                j = j + 1
            }
            //adds the identity matrix elements to the tabula
            i = 0
            j = objectiveFunctionValues.count
            while (i < tabula.count){
                tabula[i][j] = 1
                j = j + 1
                i = i + 1
            }
            
            //prints the tabula
            for tabulaRow in tabula {
                var rowString:String = ""
                for tabulaCell in tabulaRow {
                    rowString = rowString + "\(tabulaCell) "
                }
                print(rowString)
            }
            //*/
            
            /*
            for (key, value) in objectiveFunctionValues {
                print("\(key): \(value)")
            }
            var i = 1
            for element in restraintsValues{
              print("Row \(i):")
              for (key, value) in element {
                print("   \(key): \(value)")
              }
              i = i + 1
            }
            */
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
