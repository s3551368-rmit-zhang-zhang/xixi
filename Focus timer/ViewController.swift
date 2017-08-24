//
//  ViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 8/24/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shareButton: UIBarButtonItem!
   
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
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
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            
            shareButton.target = revealViewController()
            shareButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }


}
