//
//  DesignableSlider.swift
//  loan
//
//  Created by Ricardo on 2018/8/28.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableSlider: UISlider {

    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
    @IBInspectable var thumbHighlightImage: UIImage? {
        didSet {
            setThumbImage(thumbHighlightImage, for: .highlighted)
        }
    }
    
    @IBInspectable var trackHeight: CGFloat = 2
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        //set your bounds here
        
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
        
        
        
    }

}
