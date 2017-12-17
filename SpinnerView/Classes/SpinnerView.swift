//
//  SpinnerView.swift
//  SpinnerView
//
//  Created by Svante Dahlberg on 2017-12-12.
//  Copyright © 2017 Svante Dahlberg. All rights reserved.
//

import UIKit

@IBDesignable open class SpinnerView: UIView {
    
    @IBInspectable open var successColor: UIColor = .green
    @IBInspectable open var failColor: UIColor = .red
    @IBInspectable open var strokeColor: UIColor = .white
    @IBInspectable open var lineWidth: CGFloat = 5
    @IBInspectable open var hidesWhenStopped: Bool = false
    @IBInspectable private(set) open var isAnimating: Bool = false {
        didSet {
            guard !isAnimating, hidesWhenStopped else { return }
            isHidden = true
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    open func start() {
        isHidden = false
        isAnimating = true
        resetView()
        layer.addSublayer(arcShape)
        animate()
    }
    
    open func stop(success: Bool?) {
        guard let success = success else {
            removeAnimations(success: nil)
            return
        }
        let completionView = completionSymbolView(success: success)
        completionSymbolView = completionView
        addSubview(completionView)
        removeAnimations(success: success)
    }
    
    private func setupView() {
        isHidden = !isAnimating
        if isAnimating {
            start()
        }
    }
    
    private func resetView() {
        completionSymbolView?.removeFromSuperview()
        arcShape.removeFromSuperlayer()
        arcShape.removeAllAnimations()
        arcShape = initialArcShape()
        arcShape.strokeEnd = 0
    }
    
    private func animate() {
        arcShape.add(animationGroup, forKey: nil)
        arcShape.add(rotateAnimation, forKey: nil)
    }
    
    private func removeAnimations(success: Bool?) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setCompletionBlock {
            self.arcShape.removeAllAnimations()
            self.isAnimating = false
        }
        arcShape.lineWidth = 0
        arcShape.strokeColor = completionColor(success: success)
        arcShape.fillColor = completionColor(success: success)
        CATransaction.commit()
    }
    
    private func completionColor(success: Bool?) -> CGColor {
        guard let success = success else {
            return UIColor.clear.cgColor
        }
        
        return success ? successColor.cgColor : failColor.cgColor
    }
    
    // MARK: Shapes & Views
    
    private lazy var arcShape: CAShapeLayer = initialArcShape()
    
    private func initialArcShape() -> CAShapeLayer {
        let arcShape = CAShapeLayer()
        arcShape.frame = bounds
        arcShape.lineWidth = lineWidth
        arcShape.strokeColor = strokeColor.cgColor
        arcShape.fillColor = UIColor.clear.cgColor
        arcShape.lineCap = kCALineCapRound
        arcShape.path = arcPath.cgPath
        return arcShape
    }
    
    private lazy var arcPath: UIBezierPath = {
        let arcPath = UIBezierPath()
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)/2
        let startAngle: CGFloat = -.pi/2
        let endAngle: CGFloat = startAngle + .pi * 2
        arcPath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        return arcPath
    }()
    
    private var completionSymbolView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
        }
    }
    
    private func completionSymbolView(success: Bool) -> UIView {
        return success ? CheckmarkView(frame: bounds, lineWidth: lineWidth, strokeColor: strokeColor) : CrossView(frame: bounds, lineWidth: lineWidth, strokeColor: strokeColor)
    }
    
    // MARK: Animations
    
    private lazy var animationGroup: CAAnimationGroup = {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.5
        animationGroup.repeatCount = .infinity
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animationGroup.animations = [drawAnimation, eraseAnimation]
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        return animationGroup
    }()
    
    private lazy var drawAnimation: CABasicAnimation = {
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        drawAnimation.duration = 2
        drawAnimation.fillMode = kCAFillModeForwards
        drawAnimation.isRemovedOnCompletion = false
        return drawAnimation
    }()
    
    private lazy var eraseAnimation: CABasicAnimation = {
        let eraseAnimation = CABasicAnimation(keyPath: "strokeStart")
        eraseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        eraseAnimation.fromValue = 0
        eraseAnimation.toValue = 1
        eraseAnimation.duration = 2
        eraseAnimation.beginTime = 0.5
        eraseAnimation.fillMode = kCAFillModeForwards
        eraseAnimation.isRemovedOnCompletion = false
        return eraseAnimation
    }()
    
    private lazy var rotateAnimation: CABasicAnimation = {
        let rotation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotation.duration = 2.5
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = .infinity
        rotation.fillMode = kCAFillModeForwards
        rotation.fromValue = 0
        rotation.toValue = Double.pi * 2
        return rotation
    }()
    
}
