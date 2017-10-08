//
//  PastEventsTableViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 10/3/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit
import CoreData
class PastEventsTableViewController: UITableViewController{

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var eventTable: UITableView!
    
    let mContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var note = [String]()
    
    var time = [Int32]()
    
    var eventArray = [NSManagedObject]()
    
    var loginedCustomer : Customer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        sideMenus()
        eventTable.delegate = self
        eventTable.dataSource = self
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
            }
        }catch {
            fatalError("could not search：\(error)")
        }
        let fetchRequest : NSFetchRequest = CustomerizeEvent.fetchRequest()
        fetchRequest.fetchLimit = 100
        fetchRequest.fetchOffset = 0
        
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "CustomerizeEvent", in: mContext)
        
        do {
            let fetchedObjects:[AnyObject]? = try mContext.fetch(fetchRequest)
            for c:CustomerizeEvent in fetchedObjects as! [CustomerizeEvent]{
                note.append(c.note!)
                time.append(c.timeLength)
                self.eventArray.append(c)
                self.tableView.reloadData()
            }
        }catch {
            fatalError("could not search：\(error)")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : EventsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EventsTableViewCell
        cell.eventLabel?.text = note[indexPath.row]
        cell.timeLabel?.text = String(time[indexPath.row])+"s"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete
        {
           
            mContext.delete(eventArray[indexPath.row])
            eventArray.remove(at: indexPath.row)
            tableView.reloadData()
             do{
                try mContext.save()
               note.removeAll()
                time.removeAll()
                eventArray.removeAll()
               self.load()
               self.eventTable.reloadData()
            }
            catch{
                print(error)
            }
        }
        eventTable.endUpdates()
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
