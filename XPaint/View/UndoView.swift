//
//  UndoView.swift
//  XPaint
//
//  Created by XMaster on 26.10.2023.
//

import SwiftUI

struct UndoView: View {
    @ObservedObject var graphics: Graphics
    
    var body: some View {
        if let lastGrafObject = graphics.graphics.last {
            ZStack {
                
                Circle()
                    .fill(lastGrafObject.color == .white ? .black : .white)
                    .frame(width: 50, height: 50)
                    .shadow(color: .white , radius: 10, x: 0.0, y: 0.0)
                Image(systemName: "arrow.uturn.backward.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(lastGrafObject.color)

            }
            .gesture(TapGesture()
                .onEnded{ _ in
                    if !graphics.graphics.isEmpty {
                            graphics.graphics.removeLast()
                    }
                })
            .gesture(LongPressGesture(minimumDuration: 0.8)
                .onEnded({ _ in
                    graphics.graphics.removeAll()
                })
            )
        
            .padding(.leading, 10)
        }
    }
}

#Preview {
    ContentView()
}
