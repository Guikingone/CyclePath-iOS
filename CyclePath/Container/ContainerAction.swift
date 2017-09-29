//
//  ContainerAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 28/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState
{
    case collapsed
    case leftSideExpanded
}

enum ShowWichAction {
    case HomeAction
}

var showVC: ShowWichAction = .HomeAction

class ContainerAction: UIViewController
{
    var homeAction: HomeAction!
    var sideMenu: SideMenuAction!
    var centerAction: UIViewController!
    var currentState: SlideOutState = .collapsed
    var isHidden: Bool = false
    let centerPanelOffset: CGFloat = 200
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initCenter(screen: showVC)
    }
    
    func initCenter(screen: ShowWichAction)
    {
        var presentingController: UIViewController
        
        showVC = screen
        
        if homeAction == nil {
            homeAction = UIStoryboard.homeAction()
            homeAction.delegate = self
        }
        
        presentingController = homeAction
        
        if let action = centerAction {
            action.view.removeFromSuperview()
            action.removeFromParentViewController()
        }
        
        centerAction = presentingController
        
        view.addSubview(centerAction.view)
        addChildViewController(centerAction)
        centerAction.didMove(toParentViewController: self)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation
    {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return isHidden
    }
}

extension ContainerAction: CenterActionDelegate
{
    func toggleLeftPanel()
    {
        let notAlreadyExpanded = (currentState != .collapsed)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController()
    {
        if sideMenu == nil {
            sideMenu = UIStoryboard.sideMenuAction()
            addSidePanelViewController(viewController: sideMenu)
        }
    }
    
    func addSidePanelViewController(viewController: SideMenuAction)
    {
        view.insertSubview(viewController.view, at: 0)
        addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
    }
    
    @objc func animateLeftPanel(shouldExpand: Bool)
    {
        if shouldExpand {
            isHidden = !isHidden
            animateStatusBar()
            setupWhiteCover()
            currentState = .leftSideExpanded
            animateCenterXPosition(position: centerAction.view.frame.width / centerPanelOffset)
        } else {
            isHidden = !isHidden
            animateStatusBar()
            hideWhiteCover()
            animateCenterXPosition(position: 0, moved: { (finished) in
                if finished {
                    self.currentState = .collapsed
                    self.sideMenu = nil
                }
            })
        }
    }
    
    func animateCenterXPosition(position: CGFloat, moved: ((Bool) -> Void)! = nil)
    {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerAction.view.frame.origin.x = position
        }, completion: moved)
    }
    
    func animateStatusBar()
    {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    func setupWhiteCover()
    {
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 25
        
        self.centerAction.view.addSubview(whiteCoverView)
        UIView.animate(withDuration: 0.2) {
            whiteCoverView.alpha = 0.75
        }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        
        self.centerAction.view.addGestureRecognizer(tap)
    }
    
    func hideWhiteCover()
    {
//        centerAction.view.removeGestureRecognizer(tap)
        
        for subViews in self.centerAction.view.subviews {
            if subViews.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subViews.alpha = 0.0
                }, completion: { (finished) in
                    subViews.removeFromSuperview()
                })
            }
        }
    }
}

private extension UIStoryboard
{
    class func returnStoryboard() -> UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func sideMenuAction() -> SideMenuAction?
    {
        return returnStoryboard().instantiateViewController(withIdentifier: "SideMenuAction") as? SideMenuAction
    }
    
    class func homeAction() -> HomeAction?
    {
        return returnStoryboard().instantiateViewController(withIdentifier: "HomeAction") as? HomeAction
    }
}
