//
//  adminSubscription.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 7/5/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import FirebaseAuth
class adminSubscription: NSObject {

    var admin: String? //Admin user ID
    var subscription: String?
    var numberOfLawyers: String?
    var numOfActiveLawyers: String?
    
    func convertToDict()->[String:String]{        
        return ["Admin":self.admin! , "SubscriptionType":self.subscription! , "numberOfLawyers": self.numberOfLawyers!, "numberOfActiveLawyers":self.numOfActiveLawyers!]
    }
    
    init(admin: String, subsription: String){
        self.admin = admin
        self.subscription = subsription
        switch subsription{
        case "com.consult.basicsub":
            self.numberOfLawyers = "five"
            self.numOfActiveLawyers = "zero"
            break;
        case "com.consult.firm":
            self.numberOfLawyers = "twelve"
            self.numOfActiveLawyers = "zero"
            break;
        case "com.consult.team":
            self.numberOfLawyers = "twenty five"
            self.numOfActiveLawyers = "zero"
            break;
        default:
            break;
        }
        
        
    }
    
}
