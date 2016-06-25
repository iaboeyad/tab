////
////  TimeHelpers.swift
////  tab
////
////  Created by Gunnar Horve on 6/25/16.
////  Copyright © 2016 acngelhack. All rights reserved.
////
//
//import Foundation
//
//class TimeHelpers {
//    func getTimeRemaining(startTime: ???, endTime: ???) --> {
//        return ???;
//    }
//    
//    func testFunc() {
//        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval, invocation: <#T##NSInvocation#>, repeats: <#T##Bool#>)
//    }
//}
// /*
// we need to store these things locally to have a countdown timer:
//    -Game start time, gst
//    -Game duration,   gd
// We need to be able to access:
//    -stored data
//    -current time, ct
// We will update "Countdown Label" based upon...
// (gst + gd) - sd
// */