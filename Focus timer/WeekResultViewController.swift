//
//  WeekResultViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 8/26/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit
import Charts
import CoreData
class WeekResultViewController: UIViewController{
   
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var lineChart: LineChartView!
    
    let mContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext

    var time = [Int32]()
    
    var number : [Double] = []
    
    var loginedCustomer : Customer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGraph()
        sideMenus()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func load(){
        let request:NSFetchRequest = Customer.fetchRequest()
        let accountPredicate = NSPredicate(format:"accountNum =%@",AccountId.accuntnum)
        request.predicate = accountPredicate
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
                time.append(c.timeLength)
            }
        }catch {
            fatalError("could not search：\(error)")
        }
        
    }

    func updateGraph(){
        load()
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        let numbers = time.flatMap{ Double($0) }
        
        
        //here is the for loop
        for i in 0..<numbers.count {
            
            let value = ChartDataEntry(x: Double(i), y: numbers[i]) // here we set the X and Y status in a data chart entry
            
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Seconds") //Here we convert lineChartEntry to a LineChartDataSet
        
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        
        
        let data = LineChartData() //This is the object that will be added to the chart
        
        data.addDataSet(line1) //Adds the line to the dataSet
        
        lineChart.data = data
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
