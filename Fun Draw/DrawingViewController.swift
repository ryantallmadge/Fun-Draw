//
//  DrawingViewController.swift
//  Fun Draw
//
//  Created by Ryan Tallmadge on 4/8/16.
//  Copyright © 2016 Ryan Tallmadge. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    var lastPoint = CGPoint.zero;
    
    var red   : CGFloat = 0.0;
    var blue  : CGFloat = 0.0;
    var green : CGFloat = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appBecameActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
        self.blueTapped(UIButton());
    }
    
    func appBecameActive(){
        self.buttonsStackView.hidden = false;
    }
    
    func drawBetweenPoints(pointA : CGPoint, pointB : CGPoint){
        
        UIGraphicsBeginImageContext(self.imageView.frame.size);
        
        let context = UIGraphicsGetCurrentContext();
        
        self.imageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.imageView.frame.width, height: self.imageView.frame.height));
        
        CGContextMoveToPoint(context, pointB.x, pointB.y);
        
        CGContextAddLineToPoint(context, pointA.x, pointA.y);
        CGContextSetRGBStrokeColor(context, self.red, self.green, self.blue, 1);
        CGContextSetLineCap(context, .Round);
        CGContextSetLineWidth(context, 20);
        
        CGContextStrokePath(context);
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    func eraseDrawing(){
        self.imageView.image = nil;
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        self.buttonsStackView.hidden = false;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.buttonsStackView.hidden = true;
        if let touch = touches.first{
            let point = touch.locationInView(self.imageView)
            self.lastPoint = point;
            self.drawBetweenPoints(point , pointB: self.lastPoint);
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            let point = touch.locationInView(self.imageView)
            self.drawBetweenPoints(point , pointB: self.lastPoint);
            self.lastPoint = point;
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.buttonsStackView.hidden = false;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "drawingToSettings"){
            let settingsVC = segue.destinationViewController as! SettingsViewController
            settingsVC.drawingVC = self;
        }
    }
    
    @IBAction func randomTapped(sender: AnyObject) {
        self.red   = CGFloat(arc4random_uniform(256)) / 255;
        self.green = CGFloat(arc4random_uniform(256)) / 255;
        self.blue  = CGFloat(arc4random_uniform(256)) / 255;
    }
    
    @IBAction func redTapped(sender: AnyObject) {
        self.red   = 229 / 255;
        self.green = 56 / 255;
        self.blue  = 56 / 255;
    }
    
    @IBAction func yellowTapped(sender: AnyObject) {
        self.red   = 249 / 255;
        self.green = 215 / 255;
        self.blue  = 23 / 255;
    }
    
    @IBAction func greenTapped(sender: AnyObject) {
        self.red   = 37 / 255;
        self.green = 235 / 255;
        self.blue  = 114 / 255;
    }
    
    @IBAction func blueTapped(sender: AnyObject) {
        self.red   = 56 / 255;
        self.green = 109 / 255;
        self.blue  = 229 / 255;
    }
    
}

