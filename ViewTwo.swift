//
//  ViewTwo.swift
//  Focus timer
//
//  Created by Zhang Zhang on 8/18/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import Foundation
import UIKit

class ViewTwo: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var sec = 1500
    
    var timer = Timer()
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var Picker1: UIPickerView!
    
    var Array = ["1500","1800","3600"]
    
    override func viewDidLoad()
    {
        Picker1.delegate = self
        Picker1.dataSource = self
            }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        sec = Int(Array[row])!
        let minutes = Int(sec) / 60
        let seconds = Int(sec) % 60
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
        sec = Int(Array[row])!
        let minutes = Int(sec) / 60
        let seconds = Int(sec) % 60
        label.text = String(format: "%02i:%02i",minutes,seconds)
    }
     @IBOutlet weak var startOutlet: UIButton!
    
    @IBAction func start(_ sender: Any)
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewTwo.counter), userInfo: nil, repeats: true)
    }
    
    func counter()
    {
        sec -= 1
        let minutes = Int(sec) / 60
        let seconds = Int(sec) % 60
        label.text = String(format: "%02i:%02i",minutes,seconds)
        
        if (sec == 0)
        {
            timer.invalidate()
        }
    }
    
    @IBOutlet weak var stopOutlet: UIButton!
    
    @IBAction func stop(_ sender: Any)
    {
        timer.invalidate()
        sec = 1500
        label.text = "25:00"
    }
}
