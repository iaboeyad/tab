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

class ButtonController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK:  Linked variables
    @IBOutlet weak var numberOfPlayersLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var highScoreTable: UITableView!
    
    
    var score = 0;
    var scoreKeeper = NSTimer()
    var flagCaptured = false;
    
    var endTime: Double?
    var ref: FIRDatabaseReference!
    var captured = true
    let swordSlash =  NSBundle.mainBundle().URLForResource("unsheath", withExtension: "mp3")!
    var swordSlasher = AVAudioPlayer()
    var highScores = [("Player Juan",27),("Player Too",20),("Player Tree",15),("Player fore",10),("Player 5ive",5),("Player sicks",4)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        
        // Sound garbage
        do {
            swordSlasher = try AVAudioPlayer(contentsOfURL: swordSlash, fileTypeHint: nil)
            swordSlasher.prepareToPlay()
        } catch _ { }
        
        //table setup
        highScoreTable.dataSource = self
        highScoreTable.delegate = self
    }
    
    // UITableViewDataSource Functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let (name, score) = highScores[indexPath.row]
        let cell = UITableViewCell()
        let label1 = UILabel(frame: CGRect(x:0, y:0, width:CGRectGetWidth(tableView.bounds), height:50))
        let label2 = UILabel(frame: CGRect(x:0, y:0, width:CGRectGetWidth(tableView.bounds), height:50))

        label1.font =  UIFont(name: "Viking", size: 15)
        label1.text = name
        label1.backgroundColor = self.view.backgroundColor
        label1.textAlignment = .Left
        
        label2.font = UIFont(name: "Viking", size: 12)
        label2.text = String(score) + " POINTS OF VALOR"
        label2.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        label2.textAlignment = .Right
        
        cell.addSubview(label1)
        cell.addSubview(label2)
        return cell
    }
    
    // UITableViewDelegate Functions
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
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

