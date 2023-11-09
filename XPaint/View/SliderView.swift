//
//  SliderView.swift
//  XPaint
//
//  Created by XMaster on 26.10.2023.
//

import SwiftUI

struct SliderView: View {
    @State var position: CGFloat = 150.0
    @State var positionCurrent: CGFloat = 0.0
    @State var offsetMark: CGFloat = 0.0
    @State var isDrag: Bool = true
    @Binding var value: CGFloat
    @Binding var color: Color
    private let minValue: CGFloat = 0
    private let maxValue: CGFloat = 300
    let minWidth: CGFloat
    let maxWidth: CGFloat
    
    private func getRealValue() {
        value = (position + positionCurrent).transformValueByRange(from: minValue...maxValue,
                                                                   to: minWidth...maxWidth)
    }
    
    var body: some View {
        ZStack (alignment: .leading) {
            Path {p in
                p.addLines([
                    .init(x: 0, y: 25 - (minWidth / 2)),
                    .init(x: 0, y: 25 + (minWidth / 2)),
                    .init(x: 300, y: 25 + (maxWidth / 2)),
                    .init(x: 300, y: 25 - (maxWidth / 2)),
                ])
            }
            .fill(color)
            Circle()
                .stroke().stroke(lineWidth: 3).fill(.white)
                .frame(width: 50, height: 50, alignment: .center)
                .offset(x: position + positionCurrent - 25)
                .shadow(color: .white, radius: 5, x: 0.0, y: 0.0)
            Circle()
                .foregroundStyle(.gray)
                .offset(x: position + positionCurrent - 24)
                .frame(width: 48, height: 48, alignment: .center)
                .overlay {
                    Circle()
                        .foregroundStyle(color)
                        .offset(x: position + positionCurrent - 24, y: offsetMark)
                        .frame(width: value, height: value, alignment: .center)
                }
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged{ value in
                        withAnimation {
                            positionCurrent = value.translation.width
                        }
                        
                        if Int(position + positionCurrent) < Int(minValue) {
                            positionCurrent = -position
                        }
                        if Int(position + positionCurrent) > Int(maxValue) {
                            positionCurrent = maxValue - position
                        }
                        
                        withAnimation{
                            getRealValue()
                            offsetMark = -40
                        }
                    }
                    .onEnded{ value in
                        withAnimation {
                            offsetMark = 0
                            position = position + positionCurrent
                            positionCurrent = 0
                        }
                    }
                )

        }
        .frame(maxWidth: 300, maxHeight: 50)
        .onAppear {
            getRealValue()
        }
        
        // .scaleEffect(CGSize(width: 0.5, height: 1.0))
        
        //  Text("current - \(value)")
        //  Text("current - \(value.transformValueByRange(from: 0...300, to: 2...20))")
        
    }
    
}



#Preview {
    ContentView()
}
