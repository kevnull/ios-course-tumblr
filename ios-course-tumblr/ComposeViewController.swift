//
//  ComposeViewController.swift
//  ios-course-tumblr
//
//  Created by Kevin Cheng on 10/6/14.
//  Copyright (c) 2014 Kevin Cheng. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    func DEGREES_TO_RADIANS(x: Int) -> Double {
        return (M_PI * (Double(x)) / 180.0)
    }


    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var quoteButton: UIButton!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    
    var buttons: [UIButton]! = []
    var buttonOrigin: [CGFloat]! = [0, 0, 0, 0, 0, 0]
    
    @IBAction func onNevermindButton(sender: AnyObject) {
        println("dismiss")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.149019608, green: 0.203921569, blue: 0.290196078, alpha: 0.7)
        buttons.append(textButton)
        buttons.append(photoButton)
        buttons.append(quoteButton)
        buttons.append(linkButton)
        buttons.append(chatButton)
        buttons.append(videoButton)
        
        for (var i = 0; i < buttons.count; i++) {
            buttonOrigin[i] = buttons[i].center.y
            buttons[i].center.y = 330 + buttonOrigin[i]
            buttons[i].transform = CGAffineTransformMakeRotation( CGFloat( DEGREES_TO_RADIANS( Int( arc4random_uniform(359) ) ) ) )
        }
    }

    override func viewDidAppear(animated: Bool) {
        if (animated) {
            
            UIView.animateWithDuration(1,
                                delay: 0,
               usingSpringWithDamping: 0.6,
                initialSpringVelocity: 1,
                              options: nil,
                           animations: { () -> Void in
                for (var i = 0; i < self.buttons.count; i++) {
                    self.buttons[i].transform = CGAffineTransformIdentity
                    self.buttons[i].center.y = self.buttonOrigin[i]
                }
            }, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
