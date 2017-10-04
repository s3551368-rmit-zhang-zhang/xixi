//
//  PastEventsTableViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 10/3/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit
import CoreData
class PastEventsTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let mContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var event = [CustomerizeEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        //self.tableView.reloadData()
        //sideMenus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return event.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = event[indexPath.row].note
        cell.detailTextLabel?.text = String(event[indexPath.row].timeLength)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            event.remove(at: indexPath.row)
            tableView.reloadData()
        }
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
