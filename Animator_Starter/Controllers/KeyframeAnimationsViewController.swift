//
//  KeyframeAnimationsViewController.swift
//  Animator_Starter
//
//  Created by Harrison Ferrone on 18.02.18.
//  Copyright © 2018 Paradigm Shift Development, LLC. All rights reserved.
//

import UIKit

class KeyframeAnimationsViewController: UIViewController {

    // MARK: Storyboard outlets
    @IBOutlet weak var animationTarget: UIButton!
    
    var targetOffset : CGFloat {
        return animationTarget.frame.size.width / 2
    }
    
    // MARK: Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: UI Setup
        animationTarget.round(cornerRadius: animationTarget.frame.size.width/2, borderWidth: 3.0, borderColor: .black)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Fire keyframe animation
        bounceImageWithKeyframes()
        segueToNextViewController(segueID: Constants.Segues.toConstraintsVC, delay: 8)
    }

    // MARK: Keyframe animation
    func bounceImageWithKeyframes() {
        
        let origin = animationTarget.center
        
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: [.repeat, .calculationModeCubicPaced]) {
            
            // Move Right (relativeDuration: 0.25 = 25% of the entire animation)
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.animationTarget.center = AnimationManager.screenRight
                self.animationTarget.center.x -= self.targetOffset
            }
            
            // Top
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.animationTarget.center = AnimationManager.screenTop
                self.animationTarget.center.y += self.targetOffset
            }
            
            // Left
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25) {
                self.animationTarget.center = AnimationManager.screenLeft
                self.animationTarget.center.x += self.targetOffset
            }
            
            // Bottom
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                //self.animationTarget.center = AnimationManager.screenBottom
                //self.animationTarget.center.y -= self.targetOffset
                self.animationTarget.center = origin
            }
            
        }
    }
    
}
