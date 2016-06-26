//
//  ViewController.swift
//  tab
//
//  Created by Abdelrahman Ibrahim on 25/06/2016.
//  Copyright © 2016 acngelhack. All rights reserved.
//

import UIKit

class JoinGameController: UIViewController {
    
    @IBOutlet weak var gameId: UITextField!
    @IBOutlet weak var playerId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    @IBAction func joinGamePressed(sender: AnyObject) {
        print("Name Selection: \(self.playerId.text)")
        print("Game Selection: \(self.gameId.text)")
    }
}