//
//  WechatshareViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 8/25/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit
import Social

class TwitterShareViewController: UIViewController {
    
   
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareButton(_ sender: Any)
    {
        //Alert
        let alert = UIAlertController(title: "Share", message:"Share Focus today!", preferredStyle: .actionSheet)
        
        //First action
        let action = UIAlertAction(title: "Share on Twitter", style: .default)
        {(action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
            {
                let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                
                post?.setInitialText("I'm using Focus now, come and join me!")
                
                post?.add(UIImage(named:"12.png"))
                
                self.present(post!, animated: true, completion: nil)
            }
            else
            {
                self.showAlert(service: "Twitter")
            }
        }
        
        //Add action to action sheet
        alert.addAction(action)
        
        //Present alert
        self.present(alert, animated: true, completion:nil)
    }
    
    func showAlert(service:String)
    {
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler:nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion:nil)
    }
    
    
    
    func sideMenus()
    {
        if revealViewController() != nil
        {
            
            revealViewController().rearViewRevealWidth = 180
            revealViewController().rightViewRevealWidth = 180
            
            
            shareButton.target = revealViewController()
            shareButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
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
