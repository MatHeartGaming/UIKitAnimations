//
//  ConstraintAnimationsViewController.swift
//  Animator_Starter
//
//  Created by Harrison Ferrone on 18.02.18.
//  Copyright © 2018 Paradigm Shift Development, LLC. All rights reserved.
//

import UIKit

class ConstraintAnimationsViewController: UIViewController {
    
    // MARK: Storyboard outlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var newsletterView: UIView!
    @IBOutlet weak var welcomeCenterX: NSLayoutConstraint!
    @IBOutlet weak var newsletterCenterX: NSLayoutConstraint!
    
    // MARK: Additional variables
    var newsletterInfoLabel = UILabel()
    var animManager : AnimationManager!
    
    // MARK: Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Programmatic views
        newsletterInfoLabel.backgroundColor = .clear
        newsletterInfoLabel.text = "Help us make your animation code that much better by subscribing to our weekly newsletter! \n\n It's free and you can unsubscribe any time without hurting our feelings...much."
        newsletterInfoLabel.font = UIFont(name: "Bodoni 72 Oldstyle", size: 15)
        newsletterInfoLabel.textColor = .darkGray
        newsletterInfoLabel.textAlignment = .center
        newsletterInfoLabel.alpha = 0
        newsletterInfoLabel.backgroundColor = .clear
        newsletterInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        newsletterInfoLabel.numberOfLines = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: Offscreen positioning
        animManager = AnimationManager(activeContraints: [welcomeCenterX, newsletterCenterX])
        welcomeLabel.alpha = 0
        newsletterView.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Fire initial animations
        animateViewsOnScreen()
    }
    
    // MARK: Actions
    @IBAction func infoOnButtonPressed(_ sender: Any) {
        animateNewsletterHeight()
        animateWelcomeLabel()
    }
    
    
    // MARK: Animations
    
    //Place views offscreen
    func animateViewsOnScreen() {
        UIView.animate(withDuration: 1.5, delay: 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut]) { [self] in
            welcomeCenterX.constant = self.animManager.contraintOrigin[0] //Reset to original position
            welcomeLabel.alpha = 1
            newsletterCenterX.constant = self.animManager.contraintOrigin[1] //Reset to original position
            newsletterView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    func animateNewsletterHeight() {
        if let heightConstraint = newsletterView.returnContraints(withID: "NewsletterHeight") {
            print("Height contraint: \(heightConstraint.description)")
            
            if heightConstraint.constant == 350 {
                UIView.animate(withDuration: 1.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: []) {
                    heightConstraint.constant = 121
                    self.view.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 1.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                    heightConstraint.constant = 350
                    self.view.layoutIfNeeded()
                }) { _ in
                    self.addDynamicInfoLabel()
                }
            }
        } else {
            print("No Contraint found for that ID...")
        }
    }
    
    func animateWelcomeLabel() {
        
        let modifiedWelcomeTop = NSLayoutConstraint(item: welcomeLabel!,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: welcomeLabel.superview,
                                                    attribute: .top, multiplier: 1, constant: 100)
        
        
        
        if let welcomeTop = view.returnContraints(withID: "WelcomeLabelTop") {
            print(welcomeTop.description)
            welcomeTop.isActive = false
            modifiedWelcomeTop.isActive = true
        }
        
        UIView.animate(withDuration: 0.75) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func addDynamicInfoLabel() {
        newsletterView.addSubview(newsletterInfoLabel)
        
        let xAnchor = newsletterInfoLabel.centerXAnchor.constraint(equalTo: newsletterView.leadingAnchor, constant: -75)
        let yNAchor = newsletterInfoLabel.centerYAnchor.constraint(equalTo: newsletterView.centerYAnchor)
        let widthAnchor = newsletterInfoLabel.widthAnchor.constraint(equalTo: newsletterView.widthAnchor, multiplier: 0.75)
        let heightAnchor = newsletterInfoLabel.heightAnchor.constraint(equalTo: newsletterInfoLabel.widthAnchor)
        
        NSLayoutConstraint.activate([xAnchor, yNAchor, widthAnchor, heightAnchor])
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 1) { [self] in
            
            xAnchor.constant = self.newsletterView.frame.size.width / 2
            
            self.newsletterInfoLabel.alpha = 1
            
            self.view.layoutIfNeeded()
        }
        
    }

}


extension UIView {
    
    func returnContraints(withID id : String) -> NSLayoutConstraint? {
        for constraint in self.constraints {
            if constraint.identifier == id {
                return constraint
            }
        }
        return nil
    }
    
}
