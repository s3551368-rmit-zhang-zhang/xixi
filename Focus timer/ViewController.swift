//
//  ViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 8/24/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
   
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var startOutlet: UIButton!
    
    @IBOutlet weak var stopOutlet: UIButton!
    
    
    var sec = 1500
    
    var timer = Timer()
    
    var Array = ["1500","1800","3600"]
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        sideMenus()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        do
        {
            let audioPath = Bundle.main.path(forResource: "1", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch
        {
         //ERROR
        }
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
        Label.text = String(format: "%02i:%02i",minutes,seconds)
    }

    @IBAction func startAction(_ sender: Any)
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        audioPlayer.play()
    }
    
    func counter()
    {
        sec -= 1
        let minutes = Int(sec) / 60
        let seconds = Int(sec) % 60
        Label.text = String(format: "%02i:%02i",minutes,seconds)
        
        if (sec == 0)
        {
            timer.invalidate()
            audioPlayer.stop()
        }
    }
    
    @IBAction func stopAction(_ sender: Any)
    {
        timer.invalidate()
        sec = 1500
        Label.text = "25:00"
        audioPlayer.stop()
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
