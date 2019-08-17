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
    let refAdmins = Database.database().reference().child("Administrators")
    let refLawFirms = Database.database().reference().child("Law-Firms")
    let refPaidAdmins = Database.database().reference().child("PaidAdmins")
    //let refUsers = Database.database().reference().child("Users")
    
    
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
    func getAdminInfo(completionHandler: @escaping (Admin)->()){
        var thisAdmin = Admin()
        fireServices.FIRBase.refAdmins.database.reference(withPath: "Administrators").observe(.value) { (snapshots) in
            for snaps in (snapshots.value as? NSDictionary)!{
                let snap = snaps.value as? NSDictionary
                if (snap?["UID"] as! String) == Auth.auth().currentUser?.uid{
                    print("found the admin: \(snap)")
                    thisAdmin.name = snap?["name"] as? String
                    thisAdmin.email = snap?["email"] as? String
                    thisAdmin.UID = snap?["UID"] as? String
                    thisAdmin.phoneNumber = snap?["phoneNumber"] as? String
                    thisAdmin.lawFirm = snap?["lawFirm"] as? String
                }
            }
            completionHandler(thisAdmin)
        }
    }
    
    
}
