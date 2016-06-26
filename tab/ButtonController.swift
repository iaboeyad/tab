//
//  ViewController.swift
//  tab
//
//  Created by Abdelrahman Ibrahim on 25/06/2016.
//  Copyright © 2016 acngelhack. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import AVFoundation

class ButtonController: UIViewController {
    // MARK:  Linked variables
    @IBOutlet weak var numberOfPlayersLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var buttonLabel: UILabel!
    
    
    var score = 0;
    var scoreKeeper = NSTimer()
    var flagCaptured = false;
    
    var endTime: Double?
    var ref: FIRDatabaseReference!
    var captured = true
    let swordSlash =  NSBundle.mainBundle().URLForResource("unsheath", withExtension: "mp3")!
    var swordSlasher = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        
        // Sound garbage
        do {
            swordSlasher = try AVAudioPlayer(contentsOfURL: swordSlash, fileTypeHint: nil)
            swordSlasher.prepareToPlay()
        } catch _ { }
    }
    
    /*
     This function is intended to be used to unpack a game instance
     from the firebase server and store its important variables
     as class variables in this controller
     */
    func loadData() {
        // Firebase nonsense?
        self.ref = FIRDatabase.database().reference()
        ref.child("gameChannel").observeEventType(.Value, withBlock: { snapshot in
            if let numberOfPlayers = snapshot.value!.objectForKey("numberOfPlayers"){
                self.numberOfPlayersLabel.text = String(numberOfPlayers)
            }
            
            if let flagHolder = snapshot.value!.objectForKey("flagHolder"){
                if flagHolder.isEqualToString("username") {
                    //defend
                } else {
                    //capture
                }
            }
            
            if let endTime = snapshot.value!.objectForKey("endTime"){
                self.endTime = endTime.doubleValue
            } else {
                self.endTime = NSDate().timeIntervalSince1970 + 10000
            }
            
            _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ButtonController.update), userInfo: nil, repeats: true)
        })
        // Firebase nonsense?
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        let (h,m,s) = secondsToHoursMinutesSeconds(Int(endTime! - NSDate().timeIntervalSince1970))
        countdownLabel.text = "\(h):\(m):\(s)"
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        updateGraphics(sender)
        //self.ref = FIRDatabase.database().reference()
        let childUpdates = ["/gameChannel/flagHolder": "username"]
        ref.updateChildValues(childUpdates)
        
        if !flagCaptured {
            scoreKeeper = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ButtonController.increaseScore), userInfo: nil, repeats: true)
        }
    }
    
    func increaseScore(){ score+=1 }
    
    func updateGraphics(sender: UIButton) {
        swordSlasher.play()
        if(captured) {
            buttonLabel.text = "DEFEND"
            sender.setImage(UIImage(named: "shield"), forState: .Normal)
        } else {
            buttonLabel.text = "CAPTURE"
            sender.setImage(UIImage(named: "sword_right"), forState: .Normal)
        }
        captured = !captured
    }
}

