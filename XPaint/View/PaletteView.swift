//
//  Palette.swift
//  XPaint
//
//  Created by XMaster on 26.10.2023.
//

import SwiftUI

struct PaletteView: View {
    @Binding var selectedColor: Color
    @State var isShowPalette: Bool = false
    @State var offsetHeight: CGFloat = 0.0
    
    let paletteList: [Color] = [
        .black,
        .white,
        .red,
        .green,
        .blue,
        .yellow,
        .purple,
        .gray,
    ]
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                self.isShowPalette.toggle()
                withAnimation (.spring(duration: 1)) {
                    offsetHeight = self.isShowPalette ? 60.0 : 0.0
                }
            }
    }
    
    
    func allPalette(paletteList: [Color]) -> some View {
        ZStack {
            ForEach(Array(paletteList.enumerated()), id: \.offset) { id, color in
                Circle()
                    .fill(color)
                    .frame(width: 45, height: 45, alignment: .center)
                    .offset(x: 0, y: CGFloat(offsetHeight * CGFloat((id+1))))
                    .shadow(color: color, radius: 5, x: 0.0, y: 0.0)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded({ _ in
                                withAnimation (.spring(duration: 1)) {
                                    self.offsetHeight = 0.0
                                }
                                withAnimation (.spring(duration: 0.5)) {
                                    selectedColor = color
                                }
                                self.isShowPalette.toggle()
                            })
                    )
            }
            
        }
        .frame(width: 50, height: 50, alignment: .center)
        
    }
    
    var body: some View {
        ZStack {
            allPalette(paletteList: paletteList)
            Circle()
                .fill(selectedColor)
                .frame(width: 50, height: 50, alignment: .center)
                .gesture(tap)
            Circle()
                .stroke().stroke(lineWidth: 3).fill(.white)
                .frame(width: 50, height: 50, alignment: .center)
                .shadow(color: selectedColor, radius: 5, x: 0.0, y: 0.0)
            
        }
        .padding(.trailing, 10)
    }
}

#Preview {
    ContentView()
}
