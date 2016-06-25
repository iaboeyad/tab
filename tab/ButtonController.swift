//
//  ViewController.swift
//  tab
//
//  Created by Abdelrahman Ibrahim on 25/06/2016.
//  Copyright © 2016 acngelhack. All rights reserved.
//

import UIKit

class ButtonController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // TODO DON'T FORGET TO MOVE THIS LINE TO A LESS DUMB SPOT
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ButtonController.update), userInfo: nil, repeats: true)
        // TODO DON'T FORGET TO MOVE THIS LINE TO A LESS DUMB SPOT
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func takeButtonPressed(sender: AnyObject) {
        print("take button pressed")
    }

    @IBOutlet weak var numberOfPlayersLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var count = 1000
    
    func update() {
        if(count > 0) {
            countdownLabel.text = String(count--)
        }
    }
}

