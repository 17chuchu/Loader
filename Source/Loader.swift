//
//  Loader.swift
//  Loader
//
//  Created by Lucas Ortis on 06/12/2015.
//  Copyright © 2015 Ekhoo. All rights reserved.
//

import UIKit

let kInset: CGFloat = 5.0

public class Loader: UIView {

    var loaderColor: UIColor = UIColor.whiteColor()
    let switchView: UIView
    private var switchAnimationSide: Bool = false
    
    override init(frame: CGRect) {
        self.switchView = UIView(frame: CGRectMake(kInset, kInset, frame.size.height - 2 * kInset, frame.size.height - 2 * kInset))
        self.switchView.backgroundColor = UIColor(red: 255.0 / 255.0, green: 45.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0)
        self.switchView.layer.cornerRadius = round(self.switchView.frame.size.width / 2)
        self.switchView.layer.masksToBounds = true
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        self.addSubview(self.switchView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func animateSwitch() {
        if (self.frame.width > self.frame.height) {
            return;
        }
        
        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            let frame: CGRect = self.bounds
            
            if self.switchView.frame.origin.x > kInset {
                self.switchView.frame = CGRectMake(kInset, self.switchView.frame.origin.y, frame.width - 2 * kInset, self.switchView.frame.height)
            } else {
                self.switchView.frame = CGRectMake(self.switchView.frame.origin.x, self.switchView.frame.origin.y, frame.width - 2 * kInset, self.switchView.frame.height)
            }
            
            self.switchView.setNeedsDisplay()
        }) { (finished) -> Void in
            UIView.animateWithDuration(0.35, animations: { () -> Void in
                let frame: CGRect = self.bounds

                if self.switchAnimationSide {
                    self.switchView.frame = CGRectMake(kInset, self.switchView.frame.origin.y, self.switchView.frame.size.height, self.switchView.frame.height)
                } else {
                    self.switchView.frame = CGRectMake(frame.size.width - self.switchView.frame.height - kInset, self.switchView.frame.origin.y, self.switchView.frame.size.height, self.switchView.frame.height)
                }
                
                self.switchAnimationSide = !self.switchAnimationSide
                
                self.switchView.setNeedsDisplay()
            })
        }
    }
    
    func startAnimating() {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.transform = CGAffineTransformRotate(self.transform, CGFloat(M_PI_2));
        }
        
        animateSwitch()
    }
    
    public func animate() {
        NSTimer.scheduledTimerWithTimeInterval(0.5, target:self, selector: "startAnimating", userInfo: nil, repeats: true)
    }
    
    override public func drawRect(rect: CGRect) {
        let rectanglePath = UIBezierPath(roundedRect: CGRectMake(0.0, 0.0, rect.size.width, rect.size.height), cornerRadius: round(rect.size.width / 2.0))
        self.loaderColor.setFill()
        rectanglePath.fill()
    }
    
}