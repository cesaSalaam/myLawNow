//
//  HomeViewController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/10/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

// This is the clients view controller.

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var listOfClients = [Client]()
    
    override func viewDidLoad() {
        getClients()
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.selectedIndex = 1
    }
    // MARK - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfClients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell") as! clientCell
        cell.clientName.text = listOfClients[indexPath.row].name!
        return cell
    }
    
    func getClients(){
        var tempList = [Client]()
        
        fireServices.FIRBase.refClients.database.reference(withPath: "Clients").observeSingleEvent(of: .value) { (snapshhot) in
            for snap in (snapshhot.value as? NSDictionary)!{
                let items = snap.value as? NSDictionary
                let clientTemp = Client()
                if items?["lawyerId"] as? String! == (Auth.auth().currentUser?.uid as! String){
                    clientTemp.name = items?["name"] as? String
                    clientTemp.address = items?["address"] as? String
                    clientTemp.lawyerId = items?["lawyerId"] as? String
                    clientTemp.phoneNumber = items?["phoneNumber"] as? String
                    tempList.append(clientTemp)
                }
            }
            self.listOfClients = tempList
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
    

}
