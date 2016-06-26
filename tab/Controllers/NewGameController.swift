//
//  ViewController.swift
//  tab
//
//  Created by Abdelrahman Ibrahim on 25/06/2016.
//  Copyright © 2016 acngelhack. All rights reserved.
//

import UIKit

class NewGameController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var playerId: UITextField!
    @IBOutlet weak var gameId: UITextField!
    
    var pickerData: [Int] = [Int]()
    var timeSelection: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        populatePicker()
        
        //fix keyboard bug
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewGameController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //disable autocorrections
        playerId.autocorrectionType = .No
        gameId.autocorrectionType = .No
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populatePicker() {
        self.picker.delegate = self
        self.picker.dataSource = self
        for (var i = 1; i <= 60; i += 1) {
            pickerData.append(i);
        }
    }

    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row % pickerData.count])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeSelection = Int(pickerData[row])
    }
    
    @IBAction func startPressed(sender: AnyObject) {
        print("Time Selection:  \(self.timeSelection)")
        print("Name Selection: \(self.playerId.text)")
        print("Game Selection: \(self.gameId.text)")
    }
}

