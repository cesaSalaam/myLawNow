//
//  SubscriptionService.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 4/3/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//
import StoreKit
import FirebaseDatabase
import FirebaseAuth

extension Notification.Name {
    static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
}
public typealias ProductIdentifier = String

class SubscriptionService: NSObject{
    
    
    static let sessionIdSetNotification = Notification.Name("SubscriptionServiceSessionIdSetNotification")
    static let optionsLoadedNotification = Notification.Name("SubscriptionServiceOptionsLoadedNotification")
    static let restoreSuccessfulNotification = Notification.Name("SubscriptionServiceRestoreSuccessfulNotification")
    static let purchaseSuccessfulNotification = Notification.Name("SubscriptionServiceRestoreSuccessfulNotification")
    
    static let shared = SubscriptionService()
    
    var products = [SKProduct]()
    
    private var purchasedProductIdentifiers: Set<ProductIdentifier> = []
    
    var productDidPurchased: (() -> Void)?

    
    var options: [Subscription]? {
        didSet {
            NotificationCenter.default.post(name: SubscriptionService.optionsLoadedNotification, object: options)
        }
    }
    
    func loadSubscriptionOptions() {
        let products: Set = ["com.consult.basicsub", "com.consult.team", "com.consult.firm"]
        
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
         SKPaymentQueue.default().add(self)
    }
    
    func purchase(subscription: Subscription) {
        let payment = SKPayment(product: subscription.product)
        SKPaymentQueue.default().add(payment)
    }

    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    func tellingTheView(completionHandler: @escaping (String)->()){
        completionHandler("Complete")
    }
}


extension SubscriptionService: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        options = response.products.map { Subscription(product: $0) }
        self.products = response.products
        print("in here 1")
        print(options!)
        print("in here 2")
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        if request is SKProductsRequest {
            print("Subscription Options Failed Loading: \(error.localizedDescription)")
        }
    }
}

//-------------------------------------------------------------


extension SubscriptionService: SKPaymentTransactionObserver{
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            switch transaction.transactionState {
                case .purchasing: break
                case .purchased:
                    let adminSub = adminSubscription(admin: "test uid"/*Auth.auth().currentUser!.uid*/, subsription: transaction.payment.productIdentifier).convertToDict() // Create function to get the right number of total users that can be used.
                    fireServices.FIRBase.refPaidAdmins.childByAutoId().setValue(adminSub)
                    complete(transaction: transaction)
                    break
                case .failed:
                    fail(transaction: transaction)
                    break
                case .restored:
                    restore(transaction: transaction)
                    break
            default: queue.finishTransaction(transaction)
            }
        }
    }
    
    
    private func complete(transaction: SKPaymentTransaction) {
        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
        
        //let viewController = test as! PurchasesViewController
        
    }
    
    private func restore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        
        deliverPurchaseNotificationFor(identifier: productIdentifier)
        print("identifier: \(productIdentifier)")
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        print("failed...")
        if let transactionError = transaction.error as NSError?,
            let localizedDescription = transaction.error?.localizedDescription,
            transactionError.code != SKError.paymentCancelled.rawValue {
            print("Transaction Error: \(localizedDescription)")
        }
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func deliverPurchaseNotificationFor(identifier: String?) {
        guard let identifier = identifier else { return }
        
       purchasedProductIdentifiers.insert(identifier)
       UserDefaults.standard.set(true, forKey: identifier)
       NotificationCenter.default.post(name: .IAPHelperPurchaseNotification, object: identifier)
    }
}
extension SKPaymentTransactionState{
    func status() -> String{
        switch self {
        case .purchased:
            
            return "purchased made"
            break
        case .failed:
            return "purchased failed"
            break
        case .restored:
            return "restored"
            break
        case .deferred:
            return "purchase deferred"
            break
        case .purchasing:
            return "purchase being made..."
            break
        }
    }
}
