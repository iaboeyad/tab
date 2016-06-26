//
//  ViewController.swift
//  tab
//
//  Created by Abdelrahman Ibrahim on 25/06/2016.
//  Copyright © 2016 acngelhack. All rights reserved.
//

import UIKit
import FirebaseDatabase

class JoinGameController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var gameId: UITextField!
    @IBOutlet weak var playerId: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var pickerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var joinGameButton: UIButton!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var pickerData: [Int] = [Int]()
    var timeSelection: Int = 1
    var joinGameSelected = true
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //fix keyboard bug
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JoinGameController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //disable autocorrections
        playerId.autocorrectionType = .No
        gameId.autocorrectionType = .No
        
        // Connect delegates:
        self.gameId.delegate = self
        self.playerId.delegate = self
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Update UI objects:
        populatePicker()
        toggleSelection()
        
        // Some bullshit magic??
        makeMagicButton()
    }
    
    func makeMagicButton() {
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 2
        pulseAnimation.fromValue = 0.3
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = FLT_MAX
        self.playButton.layer.addAnimation(pulseAnimation, forKey: nil)
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populatePicker() {
        
        for (var i = 1; i <= 6000; i += 1) {
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
    
    @IBAction func joinGamePressed(sender: UIButton) {
        joinGameSelected = true
        toggleSelection()
    }
    @IBAction func joinGame2Pressed(sender: UIButton) {
        joinGamePressed(sender)
    }
    @IBAction func startGamePressed(sender: UIButton) {
        joinGameSelected = false
        toggleSelection()
    }
    @IBAction func startGame2Pressed(sender: UIButton) {
        startGamePressed(sender)
    }
    
    func toggleSelection() {
        if(joinGameSelected) {
            joinGameButton.titleLabel!.font =  UIFont(name: "Viking", size: 22)
            startGameButton.titleLabel!.font =  UIFont(name: "Viking", size: 15)
            picker.hidden = true
            pickerLabel.hidden = true
        } else {
            joinGameButton.titleLabel!.font =  UIFont(name: "Viking", size: 15)
            startGameButton.titleLabel!.font =  UIFont(name: "Viking", size: 22)
            picker.hidden = false
            pickerLabel.hidden = false
        }
    }
    @IBAction func playPressed(sender: UIButton) {
        if (self.gameId.text!.isEmpty || self.playerId.text!.isEmpty) {
            let alertController: UIAlertController = UIAlertController(title: "It's Unsafe!  😨", message: "Wild Pokemon live in tall... err... please fill in your text fields", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "...", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        } else {
            //            self.ref.child(self.gameId.text!).setValue(["endTime" : NSDate().timeIntervalSince1970+1000
            //                ,"flagHolder" :"current user"
            //                ,"gameName" : self.gameId.text!
            //                ,"numberOfPlayers":1
            //                ,"players":nil])
            performSegueWithIdentifier("playSegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier != "joinToButton") { return }
        //        let game: Game = Game(queryServerForGame(self.gameId.text!));
        
        //          pull the game from server by a unique string id?
        //          somehow add you to the game?
        
        //        if(game == nil) { print("failed to connect to server") }
        //        let destinationVC = segue.destinationViewController as! ButtonController
        //        destinationVC = game
    }
}