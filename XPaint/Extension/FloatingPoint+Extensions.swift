//
//  FloatingPoint+Extensions.swift
//  XPaint
//
//  Created by XMaster on 26.10.2023.
//

import Foundation

extension FloatingPoint {
    func transformValueByRange(from: ClosedRange<Self>, to: ClosedRange<Self>) -> Self {
        let position = self / from.upperBound - from.lowerBound
        return ((to.upperBound - to.lowerBound) * position) + to.lowerBound
    }
}
