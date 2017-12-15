//
//  CheckmarkView.swift
//  SpinnerView
//
//  Created by Svante Dahlberg on 2017-12-12.
//  Copyright © 2017 Svante Dahlberg. All rights reserved.
//

import UIKit

@IBDesignable open class CheckmarkView: UIView {
    
    @IBInspectable open var lineWidth: CGFloat = 5
    @IBInspectable open var strokeColor: UIColor = .white
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public init(frame: CGRect, lineWidth: CGFloat, strokeColor: UIColor) {
        self.lineWidth = lineWidth
        self.strokeColor = strokeColor
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
    
    private func setupView() {
        backgroundColor = .clear
        layer.addSublayer(checkmarkShape)
        checkmarkShape.add(drawAnimation, forKey: nil)
    }
    
    private lazy var checkmarkShape: CAShapeLayer = {
        let checkmarkShape = CAShapeLayer()
        let checkmarkRect = CGRect(x: bounds.width/4, y: bounds.height/4, width: bounds.width/2, height: bounds.height/2)
        checkmarkShape.frame = checkmarkRect
        checkmarkShape.lineWidth = lineWidth
        checkmarkShape.strokeColor = strokeColor.cgColor
        checkmarkShape.fillColor = UIColor.clear.cgColor
        
        let checkmarkPath = UIBezierPath()
        checkmarkPath.move(to: CGPoint(x: 0, y: checkmarkRect.height/2))
        checkmarkPath.addLine(to: CGPoint(x: checkmarkRect.width/2, y: checkmarkRect.height))
        checkmarkPath.addLine(to: CGPoint(x: checkmarkRect.width, y: checkmarkRect.height * 0.15))
        
        checkmarkShape.path = checkmarkPath.cgPath
        checkmarkShape.lineCap = kCALineCapRound
        checkmarkShape.lineJoin = kCALineJoinRound
        
        return checkmarkShape
    }()
    
    lazy var drawAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        return animation
    }()
    
}
