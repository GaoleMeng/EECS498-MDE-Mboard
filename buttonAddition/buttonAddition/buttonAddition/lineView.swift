//
//  lineView.swift
//  buttonAddition
//
//  Created by jingyu on 2/1/18.
//  Copyright © 2018 jingyu. All rights reserved.
//

import UIKit

class lineView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: 0, y: 0))
        aPath.addLine(to: CGPoint(x: 0, y: self.frame.height))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        aPath.lineWidth = 2
        let dashPattern : [CGFloat] = [16, 16]
        aPath.setLineDash(dashPattern, count: 2, phase: 0)
        
        //If you want to stroke it with a red color
        UIColor.black.set()
        aPath.stroke()
        //If you want to fill it as well
        //aPath.fill()
    }

}
