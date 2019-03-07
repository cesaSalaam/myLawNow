//
//  Client.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/19/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class Client: NSObject {
    var name: String?
    var phoneNumber: String?
    var address: String?
    var lawyerId: String?
    var email: String?
    
    func convertToDict() -> [String: String]{
        return ["name": self.name!, "phoneNumber" : self.phoneNumber!, "address" : self.address!, "lawyerId" : self.lawyerId!, "email" : self.email!]
    }
    
}
