//
//  UIView.swift
//  TLSafone
//
//  Created by Nguyen Van Hoa on 3/7/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import UIKit

extension UIView {

    convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    convenience init(origin: CGPoint, size: CGSize) {
        self.init(frame: CGRect(origin: origin, size: size))
    }
    public static var nib: UINib {
        return UINib(nibName: String.className(self), bundle: nil)
    }

    /*
    Create a border around the UIView
    - parameter color:  Border's color
    - parameter radius: Border's radius
    - parameter width:  Border's width
    */
    func border(color: UIColor, radius: CGFloat, width: CGFloat = 0.5) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = radius
        layer.shouldRasterize = false
        clipsToBounds = true
        layer.masksToBounds = true
        let cgColor: CGColor = color.cgColor
        layer.borderColor = cgColor
    }

    /*
    Set the corner radius of UIView
    - parameter radius: Radius value
    */
    public func cornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    /*
    Remove the borders around the UIView
    */
    public func removeBorders() {
        layer.borderWidth = 0
        layer.cornerRadius = 0
        layer.borderColor = nil
    }

    /*
    Remove the shadow around the UIView
    */
    public func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0.0
        layer.shadowOffset = CGSize.zero
    }

    /**
     Create a shake effect on the UIView
     */
    public func shakeView() {
        let shake: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        shake.values = [NSValue(caTransform3D: CATransform3DMakeTranslation(-5.0, 0.0, 0.0)),
            NSValue(caTransform3D: CATransform3DMakeTranslation(5.0, 0.0, 0.0))]
        shake.autoreverses = true
        shake.repeatCount = 2.0
        shake.duration = 0.07
        layer.add(shake, forKey:"shake")
    }

    /**
     Take a screenshot of the current view
     - returns: Returns screenshot as UIImage
     */
    public func screenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let imageData: Data = UIImagePNGRepresentation(image)!
        image = UIImage(data: imageData)!
        return image
    }

    /**
     Removes all subviews from current view
     */
    public func removeAllSubviews() {
        self.subviews.forEach { (subview) -> () in
            subview.removeFromSuperview()
        }
    }

    /**
     Create a corner radius shadow on the UIView

     - parameter cornerRadius: Corner radius value
     - parameter offset:       Shadow's offset
     - parameter opacity:      Shadow's opacity
     - parameter radius:       Shadow's radius
     */
    public func cornerRadiusAndShadow(_ cornerRadius: CGFloat, offset: CGSize, opacity: Float, radius: CGFloat) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.cornerRadius = cornerRadius
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        layer.masksToBounds = false
    }

    /**
     Create a shadow on the UIView
     - parameter offset:  Shadow's offset
     - parameter opacity: Shadow's opacity
     - parameter radius:  Shadow's radius
     */
    public func shadowWithOffset(_ offset: CGSize, opacity: Float, radius: CGFloat) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    enum BorderPostition {
        case top
        case left
        case bottom
        case right
    }

    func border(_ pos: BorderPostition, color: UIColor = UIColor.black, width: CGFloat = 0.5, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        let rect: CGRect = {
            switch pos {
            case .top: return CGRect(x: 0, y: 0, width: frame.width, height: width)
            case .left: return CGRect(x: 0, y: 0, width: width, height: frame.height)
            case .bottom: return CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
            case .right: return CGRect(x:frame.width - width, y: 0, width: width, height: frame.height)
            }
        }()
        let border = UIView(frame: rect)
        border.backgroundColor = color
        border.autoresizingMask = {
            switch pos {
            case .top:    return [.flexibleWidth, .flexibleBottomMargin]
            case .left:   return [.flexibleHeight, .flexibleRightMargin]
            case .bottom: return [.flexibleWidth, .flexibleTopMargin]
            case .right:  return [.flexibleHeight, .flexibleLeftMargin]
            }
            }()
        addSubview(border)
    }

    func shadow(color: UIColor, offset: CGSize = CGSize.zero, opacity: Float = 1.0, radius: CGFloat = 3.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(_ duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()

        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: CAAnimationDelegate = completionDelegate as! CAAnimationDelegate? {
            slideInFromLeftTransition.delegate = delegate
        }

        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved

        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }


    // Name this function in a way that makes sense to you...
    // slideFromRight, slideLeft, slideRightToLeft, etc. are great alternative names
    func slideInFromRight(_ duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransion = CATransition()

        // Set its callback delegate to the completionDelegate that was provided (if any)
//        if let delegate: AnyObject = completionDelegate {
        if let delegate: CAAnimationDelegate = completionDelegate as! CAAnimationDelegate? {
            slideInFromRightTransion.delegate = delegate
        }

        // Customize the animation's properties
        slideInFromRightTransion.type = kCATransitionPush
        slideInFromRightTransion.subtype = kCATransitionFromRight
        slideInFromRightTransion.duration = duration
        slideInFromRightTransion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromRightTransion.fillMode = kCAFillModeRemoved

        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransion, forKey: "slideInFromRightTransition")
    }

}
