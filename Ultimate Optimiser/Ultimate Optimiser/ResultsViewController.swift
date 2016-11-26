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
    
    private var solutionsArray = Array<[[Double]]>()
    private var solutionIndex:Int = 0
    
    @IBAction func QButtonClicked(_ sender: Any) {
        exit(0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var solutionText:String = ""
        solutionsArray = Solution.solutionArray
        for tabulaRow in solutionsArray[solutionIndex] {
            var rowString:String = ""
            for tabulaCell in tabulaRow {
                rowString = rowString + "\(tabulaCell) "
            }
            solutionText = solutionText + "\n" + rowString
        }
        resultsLabel.stringValue = solutionText
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
