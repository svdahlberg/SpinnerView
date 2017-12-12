//
//  CirceledCheckmarkView.swift
//  SpinnerView
//
//  Created by Svante Dahlberg on 2017-12-12.
//  Copyright © 2017 Svante Dahlberg. All rights reserved.
//

import Foundation

open class CirceledCheckmarkView: CheckmarkView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(circleShape)
        circleShape.add(drawAnimation, forKey: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var circleShape: CAShapeLayer = {
        let circleShape = CAShapeLayer()
        circleShape.frame = bounds
        circleShape.lineWidth = 5
        circleShape.strokeColor = UIColor.black.cgColor
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.path = circlePath.cgPath
        return circleShape
    }()
    
    private lazy var circlePath: UIBezierPath = {
        let circlePath = UIBezierPath()
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)/2
        circlePath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        return circlePath
    }()
}