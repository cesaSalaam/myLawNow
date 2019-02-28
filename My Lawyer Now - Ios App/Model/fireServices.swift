//
//  fireServices.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/21/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase

class fireServices: NSObject {
    static let FIRBase = fireServices()
    let refLawyers = Database.database().reference().child("Lawyers")
    let refClients = Database.database().reference().child("Clients")
    let refSessions = Database.database().reference().child("Sessions")

    
    func getClients(completionHandler: @escaping ([Client])->()){
        var tempList = [Client]()
        
        refClients.database.reference(withPath: "Clients").observeSingleEvent(of: .value) { (snapshhot) in
            for snap in (snapshhot.value as? NSDictionary)!{
                let items = snap.value as? NSDictionary
                let clientTemp = Client()
                clientTemp.name = items?["name"] as? String
                clientTemp.address = items?["address"] as? String
                clientTemp.lawyerId = items?["lawyerID"] as? String
                clientTemp.phoneNumber = items?["phoneNumber"] as? String
                tempList.append(clientTemp)
            }
            completionHandler(tempList)
        }
        
    }
}
