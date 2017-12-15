//
//  CrossView.swift
//  SpinnerView
//
//  Created by Svante Dahlberg on 2017-12-12.
//  Copyright © 2017 Svante Dahlberg. All rights reserved.
//

import UIKit

@IBDesignable open class CrossView: UIView {
    
    @IBInspectable open var lineWidth: CGFloat = 5
    @IBInspectable open var strokeColor: UIColor = .white
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    public init(frame: CGRect, lineWidth: CGFloat, strokeColor: UIColor) {
        self.lineWidth = lineWidth
        self.strokeColor = strokeColor
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        backgroundColor = .clear
        layer.addSublayer(crossShape)
        crossShape.add(drawAnimation, forKey: nil)
    }
    
    private lazy var crossShape: CAShapeLayer = {
        let crossShape = CAShapeLayer()
        let crossRect = CGRect(x: bounds.width/4, y: bounds.height/4, width: bounds.width/2, height: bounds.height/2)
        crossShape.frame = crossRect
        crossShape.lineWidth = lineWidth
        crossShape.strokeColor = strokeColor.cgColor
        crossShape.fillColor = UIColor.clear.cgColor
        
        let crossPath = UIBezierPath()
        crossPath.move(to: CGPoint(x: 0, y: 0))
        crossPath.addLine(to: CGPoint(x: crossRect.width, y: crossRect.height))
        crossPath.move(to: CGPoint(x: crossRect.width, y: 0))
        crossPath.addLine(to: CGPoint(x: 0, y: crossRect.height))
        
        crossShape.path = crossPath.cgPath
        crossShape.lineCap = kCALineCapRound
        crossShape.lineJoin = kCALineJoinRound
        
        return crossShape
    }()
    
    private lazy var drawAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        return animation
    }()
    
}

