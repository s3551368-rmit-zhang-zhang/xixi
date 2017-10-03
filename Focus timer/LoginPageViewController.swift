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
    let c1 = Customer()
    let e1 = CustomerizeEvent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        c1.addToCustomerEvent(e1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    @IBAction func signupButton(_ sender: UIButton) {
       
        if !(AccountNum.text?.isEmpty)! && !(Password.text?.isEmpty)!{
            print("TEST")
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
    }
    
    @IBAction func loginBtnClick(_ sender: Any) {
        let fetchRequest : NSFetchRequest = Customer.fetchRequest()
        fetchRequest.fetchLimit = 10
        fetchRequest.fetchOffset = 0
        
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Customer", in: mContext)
        let testAccount = "aa"
        fetchRequest.predicate = NSPredicate(format:"accountNum =%@",testAccount)
        
        do {
            let fetchedObjects:[AnyObject]? = try mContext.fetch(fetchRequest)
            for c:Customer in fetchedObjects as! [Customer]{
               c.setValue("bb", forKey: "accountNum")
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
        
    }
   
    // read from coredata
//    let fetchRequest : NSFetchRequest = Customer.fetchRequest()
//    fetchRequest.fetchLimit = 10
//    fetchRequest.fetchOffset = 0
//    
//    fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Customer", in: mContext)
//    //        fetchRequest.predicate = NSPredicate(format:"","")
//    
//    do {
//    let fetchedObjects:[AnyObject]? = try mContext.fetch(fetchRequest)
//    for c:Customer in fetchedObjects as! [Customer]{
//    print(c.accountNum)
//    print(c.password)
//    }
//    }catch {
//    fatalError("could not search：\(error)")
//    }
//
//  coredata delete
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        var dMovie:MovieViewModel?
//        var dSess : SessionViewModel?
//        var deleSeat : bookedSeatViewModel?
//        let deleteBook:BookDeal = bookDealVMS[indexPath.row].getDeal()
//        
//        for m in movies{
//            if m.movieName == deleteBook.movieName{
//                dMovie = m
//            }
//        }
//        
//        dSess = SessionViewModel(session: (dMovie?.getSpecificSession(time: deleteBook.time!))!)
//        deleSeat = bookedSeatViewModel(bookedSeat: (dSess?.getSpecificBookedSeat(seatNum: (deleteBook.seatNumber?.intValue)!))!)
//        
//        if editingStyle == UITableViewCellEditingStyle.delete {
//            orderMovieTable.beginUpdates()
//            do{
//                
//                context.delete(bookDealVMS[indexPath.row].getDeal())
//                bookDealVMS.remove(at: indexPath.row)
//                dSess?.removeBookedSeat((deleSeat?.getSeat())!)
//                try context.save()
//                print("delete successfully")
//                
//            }catch{
//                print("CoreData delete data fail")
//            }
//            orderMovieTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//            
//        }
//        orderMovieTable.endUpdates()
//    }

    

}
