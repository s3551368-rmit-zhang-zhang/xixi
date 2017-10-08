//
//  BackGroundsViewController.swift
//  Focus timer
//
//  Created by Zhang Zhang on 8/25/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit

class BackGroundsViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
    
    @IBAction func cameraBtn(_ sender: Any) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            
            let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler:{ (action: UIAlertAction) in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    imagePickerController.sourceType = .camera
                    self.present(imagePickerController, animated: true, completion: nil)
                }else {
                    print("Camera is not avaible")
                }
            } ))
            
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:{
                (action: UIAlertAction) in imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            } ))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil ))
            
            self.present(actionSheet, animated: true, completion: nil)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.image.image = image
            Image.image = image!
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
