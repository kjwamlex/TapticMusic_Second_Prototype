//
//  InterfaceController.swift
//  MiniTapticMusic Extension
//
//  Created by 김준우 on 2017. 3. 15..
//  Copyright © 2017년 Joonwoo Kim. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController,WKCrownDelegate, WCSessionDelegate {
    
    @IBOutlet var offSetUserSlider: WKInterfaceSlider!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        crownSequencer.focus()
        crownSequencer.delegate = self
        
        if (WCSession.isSupported()) {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        
        
        if WCSession.isSupported() {
            let wcsession = WCSession.default()
            wcsession.delegate = self
            wcsession.activate()
            wcsession.sendMessage(["update": "list"], replyHandler: { (dict) -> Void in
                print("InterfaceController session response: \(dict)")
            }, errorHandler: { (error) -> Void in
                print("InterfaceController session error: \(error)")
            })
        }
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
       // WKInterfaceDevice().play(.click)
        
        
        
        var replyValues = Dictionary<String, AnyObject>()
        
        switch message["command"] as! String {
            
        case "StrongBass" :
            
            //WKInterfaceDevice().play(.start)
            WKInterfaceDevice().play(.click)
            print("StrongBass")
            
            
        case "WeakBass" :
            
            WKInterfaceDevice().play(.click)
            
            print("WeakBass")
            
        case "RepeatedBass" :
            
            WKInterfaceDevice().play(.success)
            
            
        case "LongBass" :
            
            WKInterfaceDevice().play(.directionDown)
            
            
            
        default:
            break
        }

    }
    
    /*
func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {

        /*
        guard let msg = message["message"] as? Int, let value = PredefinedMessage(rawValue: msg) else {
                
                
                return
                
        }
        switch value {
            
        case .StrongBass:
            
            WKInterfaceDevice().play(.start)
    
    print("StrongBass")
            
        case .WeakBass:
            
            WKInterfaceDevice().play(.click)
            print("weakBass")
            
            default: break
        }
        */
    
    }
    
 */
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    

    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
   
        
    }

}

import Foundation

enum PredefinedMessage : Int{
    
    case StrongBass
    
    case WeakBass
    
    case HowAreYou
    
    case IHearYou
    
}
