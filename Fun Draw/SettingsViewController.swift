//
//  SettingsViewController.swift
//  Fun Draw
//
//  Created by Ryan Tallmadge on 4/8/16.
//  Copyright © 2016 Ryan Tallmadge. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    weak var drawingVC : DrawingViewController? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
    }

    @IBAction func EraseTapped(sender: AnyObject) {
        self.drawingVC?.eraseDrawing();
        navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func saveTapped(sender: AnyObject) {
        if let image = self.drawingVC?.imageView.image {
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil);
            self.presentViewController(activityVC, animated: true, completion: nil);
        }
        
    }
}
