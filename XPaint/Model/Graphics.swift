//
//  Graphics.swift
//  XPaint
//
//  Created by XMaster on  26.10.2023.
//

import SwiftUI

struct RectLine: Identifiable {
    let id = UUID()
    
    init(startPoint: CGPoint, endPoint: CGPoint) {
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    let startPoint: CGPoint
    let endPoint: CGPoint
    var linePathWithStartEnd: [CGPoint] {
        return [startPoint, endPoint]
    }
    
}

class GrafObject: Identifiable, ObservableObject {
    init(color: Color, width: CGFloat) {
        self.color = color
        self.width = width
    }
    
    @Published var lines: [RectLine] = []
    let color: Color
    let width: CGFloat
}


class Graphics: ObservableObject {
    @Published var graphics: [GrafObject] = []
}
