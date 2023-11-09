//
//  ContentView.swift
//  XPaint
//
//  Created by Denis Lyamtsev on 24.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var selectedColor: Color = .red
    @State var oldPosition: CGPoint = .zero
    @State var width: CGFloat = 8
    @State var isPainting: Bool = false
    
    @ObservedObject var mainGrap = Graphics()
    
    var grag: some Gesture {
        DragGesture(minimumDistance: 0.0)
            .onChanged { value in
                if !isPainting {
                    oldPosition = value.startLocation
                    mainGrap.graphics.append(.init(color: selectedColor, width: width))
                    
                    isPainting = true
                    mainGrap.graphics.last?.lines.append(.init(startPoint: oldPosition,
                                                               endPoint: oldPosition))
                } else {
                    
                    mainGrap.graphics.last?.lines.append(.init(startPoint: oldPosition,
                                                               endPoint: value.location))
                    mainGrap.objectWillChange.send()
                    oldPosition = value.location
                }
            }
            .onEnded{ value in
                oldPosition = .zero
                isPainting = false
            }
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.init(red: 0.8, green: 0.8, blue: 0.8))
                .ignoresSafeArea()
                .overlay {
                    ForEach(mainGrap.graphics) { graf in
                        ForEach(graf.lines) { line in
                            Path {p in
                                p.addLines(line.linePathWithStartEnd)
                            }
                            .strokedPath(StrokeStyle(lineWidth: graf.width, lineCap: .round))
                            .foregroundStyle(graf.color)
                        }
                    }
                }
            VStack {
                HStack {
                    UndoView(graphics: mainGrap)
                    Spacer()
                    PaletteView(selectedColor: $selectedColor)
                }
                Spacer()
                SliderView(value: $width, color: $selectedColor, minWidth: 2, maxWidth: 20)
            }
        }
        .gesture(grag)
    }
}

#Preview {
    ContentView()
}
