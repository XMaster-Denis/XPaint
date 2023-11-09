//
//  Graphics.swift
//  XPaint
//
//  Created by XMaster on 26.10.2023.
//

import SwiftUI

struct RectLine: Identifiable {
    let id = UUID()
    
    init(startPoint: CGPoint, endPoint: CGPoint, width: CGFloat) {
        
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.width = width
        
        let vectorAB = endPoint - startPoint
        let vectorAC90 = vectorAB.vector90()
        let vectorAC270 = vectorAB.vector270()
        let distanceAB: CGFloat = endPoint.distance(to: startPoint)
        let normalVector90 = vectorAC90.division(by: distanceAB)
        let normalVector270 = vectorAC270.division(by: distanceAB)
        let normalVectorDistance90 = normalVector90.multiplication(by: width / 2)
        let normalVectorDistance270 = normalVector270.multiplication(by: width / 2)
        p1 = normalVectorDistance90 + startPoint
        p2 = normalVectorDistance90 + endPoint
        p3 = normalVectorDistance270 + endPoint
        p4 = normalVectorDistance270 + startPoint
//        print(p1)
//        print(p2)
//        print(p3)
//        print(p4)
    }
    
    let startPoint: CGPoint
    let endPoint: CGPoint
    let width: CGFloat
    
    var p1: CGPoint = .zero
    var p2: CGPoint = .zero
    var p3: CGPoint = .zero
    var p4: CGPoint = .zero
    
    var linePath: [CGPoint] {
        return [p1, p2, p3, p4]
    }
    
    var rectEllipse: CGRect {
        .init(x: endPoint.x - width / 2,
              y: endPoint.y - width / 2,
              width: width, height: width)
    }
}

class GrafObject: Identifiable, ObservableObject {

    
    init(color: Color) {
        self.color = color
    }
    
    @Published var lines: [RectLine] = []
    let color: Color
    
}


class Graphics: ObservableObject {
    @Published var graphics: [GrafObject] = []
}
