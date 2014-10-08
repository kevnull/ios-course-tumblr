//
//  TabViewController.swift
//  ios-course-tumblr
//
//  Created by Kevin Cheng on 10/6/14.
//  Copyright (c) 2014 Kevin Cheng. All rights reserved.
//

import UIKit

class TabViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    var isPresenting : Bool = false
    var selectedButton : UIButton!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var composeButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var trendingButton: UIButton!


    @IBAction func onTabButton(sender: UIButton) {
        sender.selected = !sender.selected
        
        // a way to have this controller own the others
        
        var homeViewController = storyboard?.instantiateViewControllerWithIdentifier("homeView") as HomeViewController
        var accountViewController = storyboard?.instantiateViewControllerWithIdentifier("accountView") as AccountViewController
        var composeViewController = storyboard?.instantiateViewControllerWithIdentifier("composeView") as ComposeViewController
        var searchViewController = storyboard?.instantiateViewControllerWithIdentifier("searchView") as SearchViewController
        var trendingViewController = storyboard?.instantiateViewControllerWithIdentifier("trendingView") as TrendingViewController

        
        if (selectedButton != nil) {
            selectedButton.selected = false
        }
        selectedButton = sender
        
        if (sender == homeButton) {
            println("home")
            contentView.addSubview(homeViewController.view)

        } else if (sender == accountButton) {
            println("account")
            contentView.addSubview(accountViewController.view)

        } else if (sender == composeButton) {
//            contentView.frame = view.frame
//            view.bringSubviewToFront(contentView)
            performSegueWithIdentifier("composeSegue", sender: self)

        } else if (sender == searchButton) {
//            contentView.addSubview(searchViewController.view)
            performSegueWithIdentifier("searchSegue", sender: self)

        } else if (sender == trendingButton) {
//            contentView.addSubview(trendingViewController.view)
            performSegueWithIdentifier("trendingSegue", sender: self)

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var homeViewController = storyboard?.instantiateViewControllerWithIdentifier("homeView") as HomeViewController

        self.contentView.addSubview(homeViewController.view)
        homeButton.selected = true
        
        homeButton.setImage(UIImage(named: "home_selected_icon"), forState: UIControlState.Selected)
        accountButton.setImage(UIImage(named: "account_selected_icon"), forState: UIControlState.Selected)
        searchButton.setImage(UIImage(named: "search_selected_icon"), forState: UIControlState.Selected)
        trendingButton.setImage(UIImage(named: "trending_selected_icon"), forState: UIControlState.Selected)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as UIViewController
        println(segue.identifier)
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        println(contentView.frame)
        if (isPresenting) {
            contentView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    println("complete: isAnimated: \(transitionContext.isAnimated()); isInteractive: \(transitionContext.isInteractive()); finished: \(finished); presentation: \(transitionContext.presentationStyle())")
            }
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    
}
