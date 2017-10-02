//
//  LoginPageViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 10/2/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit
import SQLite
class LoginPageViewController: UIViewController {

    var database : Connection!
    
    let userInfoTable = Table("userInfo")
    
    let id = Expression<Int>("id")
    
    let userId = Expression<String>("userId")
    
    let password = Expression<String>("password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("userInfo").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
            
        }catch {
            print(error)
        }
        
        self.createTable()
       //self.deletTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func createTable(){
        
        let createTable = self.userInfoTable.create { (table) in
            table.column(self.id, primaryKey: .autoincrement)
            table.column(self.userId, unique: true)
            table.column(self.password)
        }
        
        do{
            try self.database.run(createTable)
            print("Created Table")
        }catch{
            print(error)
        }
    }

    
    @IBAction func signupButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Insert user info", message:nil, preferredStyle: .alert)
        
        alert.addTextField { (tf) in
            tf.placeholder = "UserId"
        }
        alert.addTextField { (tf) in
            tf.placeholder = "Password"
        }
        
            let action = UIAlertAction(title: "Submite",  style: .default)
            {(_) in
            guard let userId = alert.textFields?.first?.text,
                let password = alert.textFields?.last?.text
                else{return}
            
            let inserUser = self.userInfoTable.insert(self.userId <- userId, self.password <- password)
            
            do{
                try self.database.run(inserUser)
                print("Inserted user")
            }catch{
                print(error)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func deletTable(){
        do{
            try self.database.run(userInfoTable.drop())
            print("Deleted")
        }catch{
            print(error)
        }
    }
    
    @IBAction func asndi(_ sender: UIButton) {
        do {
            let users = try self.database.prepare(self.userInfoTable)
            for user in users{
                print("userId: \(user[self.id]), email: \(user[self.userId]), password: \(user[self.password])")
            }
        }catch{
            print(error)
            
        }
    }

   

}
