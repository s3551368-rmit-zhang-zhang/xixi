//
//  BackGroundsViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 8/25/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit

class BackGroundsViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = Image.image
        sideMenus()
        
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
    
    @IBAction func crystalButton(_ sender: UIButton) {
        
        image.image = UIImage(named:"1746b313b31e17a6065a86cee3e249f0")
        Image.image = UIImage(named:"1746b313b31e17a6065a86cee3e249f0")!
        
    }
    
    @IBAction func marbleButton(_ sender: UIButton) {
        
        image.image = UIImage(named:"5b2fe7d91e05f57bce2f80b325cbe45e--white-iphone-background-white-wallpaper-iphone")
        Image.image = UIImage(named:"5b2fe7d91e05f57bce2f80b325cbe45e--white-iphone-background-white-wallpaper-iphone")!
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
