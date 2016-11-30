//
//  ViewController.swift
//  Ultimate Optimiser
//
//  Created by Anton Dominique Cruz on 10/11/2016.
//  Copyright © 2016 adtcruz. All rights reserved.
//

import Cocoa

class ResultsViewController: NSViewController {
    
    @IBOutlet var iterationLabel: NSTextField!
    @IBOutlet var resultsLabel: NSTextField!
    @IBOutlet var backButtonOut: NSButton!
    @IBOutlet var nextButtonOut: NSButton!
    
    
    private var solutionsArray = Array<[[Double]]>()
    private var solutionIndex:Int = 0
    
    @IBAction func QButtonClicked(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        if(solutionIndex == 0){
            return
        }
        solutionIndex = solutionIndex - 1
        var solutionText:String = ""
        for tabulaRow in solutionsArray[solutionIndex] {
            var rowString:String = ""
            for tabulaCell in tabulaRow {
                rowString = rowString + "\(tabulaCell) "
            }
            solutionText = solutionText + "\n" + rowString
        }
        resultsLabel.stringValue = solutionText
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if(solutionIndex == (solutionsArray.count - 1)){
            return
        }
        solutionIndex = solutionIndex - 1
        var solutionText:String = ""
        for tabulaRow in solutionsArray[solutionIndex] {
            var rowString:String = ""
            for tabulaCell in tabulaRow {
                rowString = rowString + "\(tabulaCell) "
            }
            solutionText = solutionText + "\n" + rowString
        }
        resultsLabel.stringValue = solutionText
        nextButtonOut.state = NSOnState
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var solutionText:String = ""
        solutionsArray = Solution.solutionArray
        for tabulaRow in solutionsArray[0] {
            var rowString:String = ""
            for tabulaCell in tabulaRow {
                rowString = rowString + "\(tabulaCell) "
            }
            solutionText = solutionText + "\n" + rowString
        }
        resultsLabel.stringValue = solutionText
        /*
        if(solutionsArray.count == 1){
            nextButtonOut.state = NSOffState
            //nextButtonOut.isEnabled = false
            nextButtonOut.setNeedsDisplay()
        }
        backButtonOut.state = NSOffState
        //backButtonOut.isEnabled = false
        backButtonOut.setNeedsDisplay()
        */
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
