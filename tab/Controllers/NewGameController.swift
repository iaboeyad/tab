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
    
    @IBAction func newGamePressed(sender: AnyObject) {
        if (self.gameId.text!.isEmpty || self.playerId.text!.isEmpty)
        {
            let alertController: UIAlertController = UIAlertController(title: "Woah There!", message: "Fill in some text!!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok...", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        } else {
        performSegueWithIdentifier("newToButton", sender: nil)
        }
    }
    @IBAction func joinGamePressed(sender: AnyObject) {
        performSegueWithIdentifier("newToJoin", sender: nil)
    }
            //        let game: Game = Game(queryServerForGame(self.gameId.text!));
            
            //          pull the game from server by a unique string id?
            //          somehow add you to the game?
            
            //        if(game == nil) { print("failed to connect to server") }
            //print(segue.destinationViewController.title)
            //let destinationVC = segue.destinationViewController as! ButtonController
            //        destinationVC = game

}

