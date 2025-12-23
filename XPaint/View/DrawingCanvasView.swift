//
//  DrawingCanvasView.swift
//  XPaint
//
//  Created by XMaster on 04.12.25.
//
import SwiftUI

struct DrawingCanvasView: View {
    @ObservedObject var mainGrap: Graphics
    
    var body: some View {
        Rectangle()
        .fill(Color.init(red: 0.8, green: 0.8, blue: 0.8))
      
        .overlay {
            ForEach(mainGrap.graphics) { graf in
                GrafView(graf: graf)
            }
        }
    }
}

                
