//
//  ViewController.swift
//  tab
//
//  Created by Abdelrahman Ibrahim on 25/06/2016.
//  Copyright © 2016 acngelhack. All rights reserved.
//

import UIKit

class ButtonController: UIViewController {
    // MARK:  Linked variables
    @IBOutlet weak var numberOfPlayersLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    // MARK:  Unpacked game objects
    var endTime: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        unpackGameData()
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ButtonController.update), userInfo: nil, repeats: true)
    }
    
    /* 
     This function is intended to be used to unpack a game instance
     from the firebase server and store its important variables
     as class variables in this controller
     */
    func unpackGameData() {
        endTime = NSDate().timeIntervalSince1970 + 10000
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takeButtonPressed(sender: AnyObject) {
        print("take button pressed")
    }
    
    func update() {
        let (h,m,s) = secondsToHoursMinutesSeconds(Int(endTime! - NSDate().timeIntervalSince1970))
        countdownLabel.text = "\(h):\(m):\(s)"
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}

