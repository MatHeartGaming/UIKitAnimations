//
//  AnimationManager.swift
//  Animator_Starter
//
//  Created by Matteo Buompastore on 16/09/23.
//  Copyright © 2023 Paradigm Shift Development, LLC. All rights reserved.
//

import UIKit

class AnimationManager {
    
    // Calculated Screen Bounds
    static var screenBounds : CGRect {
        return UIScreen.main.bounds
    }
    
    
    //Screen positions
    static var screenRight : CGPoint {
        return CGPoint(x: screenBounds.maxX, y: screenBounds.midY)
    }
    
    static var screenTop : CGPoint {
        return CGPoint(x: screenBounds.midX, y: screenBounds.minY)
    }
    
    static var screenLeft : CGPoint {
        return CGPoint(x: screenBounds.minX, y: screenBounds.midY)
    }
    
    static var screenBottom : CGPoint {
        return CGPoint(x: screenBounds.midX, y: screenBounds.maxY)
    }
    
    
    // Tracking variables
    var contraintOrigin = [CGFloat]()
    var currentContrinats : [NSLayoutConstraint]!
    
    init(activeContraints : [NSLayoutConstraint]) {
        for contraint in activeContraints {
            contraintOrigin.append(contraint.constant)
            
            // Set views offscreen
            contraint.constant -= AnimationManager.screenBounds.width
        }
        
        currentContrinats = activeContraints
        
    }
    
}
