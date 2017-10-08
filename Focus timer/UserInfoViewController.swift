//
//  UserInfoViewController.swift
//  Focus timer
//
//  Created by James zhang on 8/10/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit
import CoreData
class UserInfoViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
   
    @IBOutlet weak var accountNum: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    let mContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var loginedCustomer : Customer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        load()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func load(){
        let request:NSFetchRequest = Customer.fetchRequest()
        let accountPredicate = NSPredicate(format:"accountNum =%@",AccountId.accuntnum)
        let passwordPredicate = NSPredicate(format:"password =%@",AccountId.password)
        let compound:NSCompoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [accountPredicate,passwordPredicate])
        request.predicate = compound
        request.fetchLimit = 1
        request.fetchOffset = 0
        
        request.entity = NSEntityDescription.entity(forEntityName: "Customer", in: mContext)
        
        do {
            let fetchedObjects:[AnyObject]? = try mContext.fetch(request)
            
            for c:Customer in fetchedObjects as![Customer] {
                self.loginedCustomer = c
                accountNum?.text = c.accountNum
                passwordTF?.text = c.password
            }
        }catch {
            fatalError("could not search：\(error)")
        }
    }
    
    @IBAction func editeBtn(_ sender: Any) {
        passwordTF.isEnabled = true
        accountNum.isEnabled = true
    }
    
    
    @IBAction func saveDetail(_ sender: Any) {
        let fetchRequest : NSFetchRequest = Customer.fetchRequest()
        fetchRequest.fetchLimit = 10
        fetchRequest.fetchOffset = 0
        
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Customer", in: mContext)
        fetchRequest.predicate = NSPredicate(format:"accountNum =%@",AccountId.accuntnum)
        do {
            let fetchedObjects:[AnyObject]? = try mContext.fetch(fetchRequest)
            for c:Customer in fetchedObjects as! [Customer]{
                c.setValue(accountNum.text, forKey: "accountNum")
                c.setValue(passwordTF.text, forKey: "password")
            }
        }catch {
            fatalError("could not search：\(error)")
        }

        do{
            try mContext.save()
            print("Change ID Successfully")
        }catch{
            print("Fail to change")
        }
        accountNum.text = accountNum.text
        passwordTF.text = passwordTF.text
    }
    
    func sideMenus()
    {
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 180
            revealViewController().rightViewRevealWidth = 180
            
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }


}
