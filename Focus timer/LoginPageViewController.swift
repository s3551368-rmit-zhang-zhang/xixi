//
//  LoginPageViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 10/2/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class LoginPageViewController: UIViewController {
    let mContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    @IBOutlet weak var AccountNum: UITextField!
    @IBOutlet weak var Password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    @IBAction func LoginButton(_ sender: UIButton) {
       
        if !(AccountNum.text?.isEmpty)! && !(Password.text?.isEmpty)!{
            let request:NSFetchRequest = Customer.fetchRequest()
            let accountPredicate = NSPredicate(format:"accountNum =%@",AccountNum.text!)
            let passwordPredicate = NSPredicate(format:"password =%@",Password.text!)
            let compound:NSCompoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [accountPredicate,passwordPredicate])
            request.predicate = compound
            request.fetchOffset = 0
            
            request.entity = NSEntityDescription.entity(forEntityName: "Customer", in: mContext)
            
            do {
                let fetchedObjects:[AnyObject]? = try mContext.fetch(request)
                
                for c:Customer in fetchedObjects as![Customer] {
                    print(c.password)
                }
                if (fetchedObjects?.isEmpty)!{
                    // register a new customer
                    let customer = NSEntityDescription.insertNewObject(forEntityName: "Customer", into: mContext) as! Customer
                    customer.accountNum = AccountNum.text
                    customer.password = Password.text
                    
                    do{
                        try mContext.save()
                        print("save customer successfully")
                    }catch{
                        print("fail to save")
                    }
                }
            }catch {
                fatalError("could not search：\(error)")
            }
            AccountId.accuntnum = AccountNum.text!
            AccountId.password = Password.text!
            self.performSegue(withIdentifier: "logined", sender: nil)
        }
}
//    @IBAction func loginBtnClick(_ sender: Any) {
//        let fetchRequest : NSFetchRequest = Customer.fetchRequest()
//        fetchRequest.fetchLimit = 10
//        fetchRequest.fetchOffset = 0
//        
//        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Customer", in: mContext)
//        let testAccount = "aa"
//        fetchRequest.predicate = NSPredicate(format:"accountNum =%@",testAccount)
//        
//        do {
//            let fetchedObjects:[AnyObject]? = try mContext.fetch(fetchRequest)
//            for c:Customer in fetchedObjects as! [Customer]{
//               c.setValue("bb", forKey: "accountNum")
//            }
//        }catch {
//            fatalError("could not search：\(error)")
//        }
//        
//        do{
//            try mContext.save()
//            print("Change ID Successfully")
//        }catch{
//            print("Fail to change")
//        }
//        
//    }
   
}
