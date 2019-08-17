//
//  PurchasesViewController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 4/1/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import StoreKit

class PurchasesViewController: UITableViewController {

    var products: [SKProduct] = []
    var options: [Subscription]?
    
    @IBAction func restorePurchase(_ sender: Any) {
        SubscriptionService.shared.restorePurchases()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.rowHeight = 117.0
        
        //IAPService.shared.getProducts( )
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        options = SubscriptionService.shared.options
        SubscriptionService.shared.loadSubscriptionOptions()
       
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleOptionsLoaded(notification:)),
                                               name: SubscriptionService.optionsLoadedNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handlePurchaseSuccessfull(notification:)),
                                               name: SubscriptionService.purchaseSuccessfulNotification,
                                               object: nil)
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
 
 
    
    }
    
    @objc func handleOptionsLoaded(notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.options = SubscriptionService.shared.options
            self?.tableView.reloadData()
        }
    }
    
    @objc func handlePurchaseSuccessfull(notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath) as! SubscriptionOptionTableViewCell
        guard let option = options?[indexPath.row] else { return cell }
        cell.nameLabel?.text = option.product.localizedTitle
        cell.descriptionLabel.text = option.product.localizedDescription
        cell.priceLabel.text = option.formattedPrice
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let option = options?[indexPath.row] else { return }
        SubscriptionService.shared.purchase(subscription: option)
        
    }

}
