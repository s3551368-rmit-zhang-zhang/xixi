//
//  MusicViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 8/24/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit

class MusicTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!

    @IBOutlet weak var Alpha: UIButton!
    @IBOutlet weak var Magic: UIButton!
    @IBOutlet weak var Mistery: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        // Do any additional setup after loading the view.
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
            
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    
    @IBAction func alphaMusic(_ sender: UIButton) {
        Music.music = Bundle.main.path(forResource: "Alpha", ofType: ".mp3")
        
        Alpha.backgroundColor = UIColor.lightGray
        Magic.backgroundColor = UIColor.clear
        Mistery.backgroundColor = UIColor.clear
        
        
    }
    
    
    @IBAction func magicMusic(_ sender: UIButton) {
        Music.music = Bundle.main.path(forResource: "Magic", ofType: ".mp3")
        
            Alpha.backgroundColor = UIColor.clear
            Magic.backgroundColor = UIColor.lightGray
            Mistery.backgroundColor = UIColor.clear
    }
    
    
    @IBAction func misteryMusic(_ sender: UIButton) {
          Music.music = Bundle.main.path(forResource: "Mistery", ofType: ".mp3")
        
        Alpha.backgroundColor = UIColor.clear
        Magic.backgroundColor = UIColor.clear
        Mistery.backgroundColor = UIColor.lightGray
   
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
