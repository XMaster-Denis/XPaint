//
//  CGPoint+Extensions.swift
//  XPaint
//
//  Created by XMaster on 26.10.2023.
//

import SwiftUI

extension CGPoint {
    
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
    func division(by: CGFloat) -> CGPoint {
        return CGPoint(x: x / by, y: y / by)
    }
    func multiplication(by: CGFloat) -> CGPoint {
        return CGPoint(x: x * by, y: y * by)
    }
    static func +(left: CGPoint, right: CGPoint)->CGPoint{
        return CGPoint(x: left.x+right.x, y: left.y+right.y)
    }
    static prefix func -(right: CGPoint)->CGPoint{
        return CGPoint(x: -right.x, y: -right.y)
    }
    static func -(left: CGPoint, right: CGPoint)->CGPoint{
        return left + (-right)
    }
    func vector90()->CGPoint{
        return CGPoint(x: y, y: -x)
    }
    func vector270()->CGPoint{
        return CGPoint(x: -y, y: x)
    }
}
