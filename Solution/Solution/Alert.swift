//
//  Alert.swift
//  Solution
//
//  Created by Nick on 7/25/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    static let sharedInstance = Alert()
    
    enum errorType: String {
        case jsonMissingKey = "There was an error parsing the JSON response. A key was missing."
        case JSONParseError = "Unable to parse JSON recieved from server."
        case NetworkError = "There was a problem recieving data from the network. Please check your network settings and try again."
        
    }
    
    func displayAlert(error: errorType) {
        dispatch_async(dispatch_get_main_queue()) {
            let alertController = DBAlertController(title: "Error", message: error.rawValue, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default) {
                (action) in
                alertController.dismissViewControllerAnimated(true, completion: nil)
                })
            alertController.show()
        }
        
    }
}
