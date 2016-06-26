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
    @IBOutlet weak var captureButton: UIButton!
    var gameChannelName: String!
    var currentPlayerName: String!
    
    var endTime: Double?
    var ref: FIRDatabaseReference!
    var captured = false
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
        ref.child(gameChannelName).observeEventType(.Value, withBlock: { snapshot in
            if let numberOfPlayers = snapshot.value!.objectForKey("numberOfPlayers") {
                self.numberOfPlayersLabel.text = String(numberOfPlayers)
            }
            
            if let flagHolder = snapshot.value!.objectForKey("flagHolder") {
                if flagHolder.isEqualToString(self.currentPlayerName) {
                    //defend
                    self.captured = true
                    self.updateGraphics()
                    print(flagHolder)
                } else {
                    //capture
                    self.captured = false
                    self.updateGraphics()
                    print(flagHolder)
                }
            }
            
            if let endTime = snapshot.value!.objectForKey("endTime") {
                self.endTime = endTime.doubleValue
            } else {
                self.endTime = NSDate().timeIntervalSince1970 + 10000
            }
            
            //if let playerScore = snapshot.value!.objectForKey("/\(self.currentPlayerName)/score") {
            if let playerScore = snapshot.value!.objectForKey("players") {
                //self.score = Int(playerScore as! NSNumber)
                //print("xxxxxxxxxx \(playerScore)")
                //self.playerScoreLabel.text = String(playerScore)
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
        updateGraphics()
        let childUpdates = ["/\(gameChannelName)/flagHolder": currentPlayerName]
        ref.updateChildValues(childUpdates)
        
        if !captured {
            scoreKeeper = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ButtonController.increaseScore), userInfo: nil, repeats: true)
            captured = true
        }
    }
    
    func increaseScore(){ score+=1 }
    
    func updateGraphics() {
        swordSlasher.play()
        if(captured) {
            buttonLabel.text = "DEFEND"
            captureButton.setImage(UIImage(named: "shield"), forState: .Normal)
        } else {
            buttonLabel.text = "CAPTURE"
            captureButton.setImage(UIImage(named: "sword_right"), forState: .Normal)
        }
        captured = !captured
    }
}

