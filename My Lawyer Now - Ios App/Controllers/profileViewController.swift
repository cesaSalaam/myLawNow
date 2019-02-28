//
//  profileViewController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/22/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class profileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var arrayOfSettings = ["My Info","Clear Call History","Account", "About", "Legal"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = arrayOfSettings[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @objc func addingClient(){
        print("adding Client")
    }
    
    override func viewWillLayoutSubviews() {
        //profileImage.layer.cornerRadius = profileImage.frame.height / 2.0
       // profileImage.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
