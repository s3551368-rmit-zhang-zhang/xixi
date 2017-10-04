//
//  homePageViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 10/4/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import AVFoundation

class homePageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var accountnum = ""
    
    let mContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var startOutlet: UIButton!
    
    @IBOutlet weak var stopOutlet: UIButton!
    
    @IBOutlet weak var focusLabel: UILabel!
    
    @IBOutlet weak var backgroundView: UIImageView!{
        didSet{
            backgroundView.image = Image.image
        }
    }
    
    @IBOutlet weak var noteField: UITextField!
    
    var loginedCustomer : Customer?
    
    var PresetedSec = 1500
    
    var oriSec = 1500
    
    var timer = Timer()
    
    var Array = ["1500","1800","3600"]
    
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad()
    {
        sideMenus()
        pickerView.delegate = self
        pickerView.dataSource = self
        startOutlet.isHidden = false
        focusLabel.isHidden = true
        menuButton.isEnabled = true
        shareButton.isEnabled = true
        
        do
        {
            let audioPath = Music.music
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch
        {
            //ERROR
        }
        super.viewDidLoad()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        PresetedSec = Int(Array[row])!
        oriSec = Int(Array[row])!
        let minutes = Int(PresetedSec) / 60
        let seconds = Int(PresetedSec) % 60
        return String(format: "%02i:%02i",minutes,seconds)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return Array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        PresetedSec = Int(Array[row])!
        let minutes = Int(PresetedSec) / 60
        let seconds = Int(PresetedSec) % 60
        Label.text = String(format: "%02i:%02i",minutes,seconds)
    }
    
    @IBAction func startAction(_ sender: Any)
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(homePageViewController.counter), userInfo: nil, repeats: true)
        startOutlet.isHidden = true
        focusLabel.isHidden = false
        audioPlayer.play()
        menuButton.isEnabled = false
        shareButton.isEnabled = false
    }
    
    func counter()
    {
        PresetedSec -= 1
        oriSec = PresetedSec
        let minutes = Int(PresetedSec) / 60
        let seconds = Int(PresetedSec) % 60
        Label.text = String(format: "%02i:%02i",minutes,seconds)
        
        if (PresetedSec == 0)
        {
            timer.invalidate()
            audioPlayer.stop()
        }
    }
    
    @IBAction func stopAction(_ sender: Any)
    {
        startOutlet.isHidden = false
        focusLabel.isHidden = true
        timer.invalidate()
        PresetedSec = 1500
        Label.text = "25:00"
        audioPlayer.stop()
        menuButton.isEnabled = true
        shareButton.isEnabled = true
        createEvent()
    }
    
    // !!!!!!!!!!!!
    func createEvent(){
        //let account = "zeo"
        let request:NSFetchRequest = Customer.fetchRequest()
        let accountPredicate = NSPredicate(format:"accountNum =%@",accountnum)
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
        let event = NSEntityDescription.insertNewObject(forEntityName: "CustomerizeEvent", into: mContext) as! CustomerizeEvent
        event.note = noteField.text
        let gap =  PresetedSec - oriSec
        print (gap)
        event.timeLength = Int32.init(exactly: gap)!
        
        event.owner = loginedCustomer
        loginedCustomer?.addToCustomerEvent(event)
        
        do{
            try mContext.save()
            print("save EVENT successfully")
            print(event.note)
            print(Int(event.timeLength))
            print(event.owner?.accountNum)
        }catch{
            print("ERROR")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sideMenus()
    {
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 180
            revealViewController().rightViewRevealWidth = 180
            
            
            shareButton.target = revealViewController()
            shareButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    


}
