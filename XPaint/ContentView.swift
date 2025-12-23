//
//  ContentView.swift
//  XPaint
//
//  Created by Denis Lyamtsev  on 24.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var selectedColor: Color = .red
    @State var oldPosition: CGPoint = .zero
    @State var width: CGFloat = 8
    @State var isPainting: Bool = false
    @State private var canvasSize: CGSize = .zero
    
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
            DrawingCanvasView(mainGrap: mainGrap)
            
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                self.canvasSize = geo.size
                            }
                            .onChange(of: geo.size) { newSize in
                                canvasSize = newSize
                            }
                    }
                )
                .gesture(grag)
                .ignoresSafeArea()
            VStack {
                HStack {
                    UndoView(graphics: mainGrap)
                    Spacer()
                    Button {
                        saveCanvasToPhotos()
                    } label: {
                        ZStack {
                         
//                            Circle()
//                                .fill(selectedColor)
//                                .frame(width: 50, height: 50, alignment: .center)
//                              
                            Circle()
                                .stroke().stroke(lineWidth: 3).fill(.white)
                                .frame(width: 50, height: 50, alignment: .center)
                                .shadow(color: .white, radius: 5, x: 0.0, y: 0.0)
                            Image(systemName: "square.and.arrow.down")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 40, alignment: .center)
                                .offset(x: 0, y: -3)
                                .shadow(color: .blue, radius: 2, x: 1.0, y: 1.0)
                            
                            
                        }
                        .padding(.trailing, 10)
                        
                    }
                    
                    
                    PaletteView(selectedColor: $selectedColor)
                }
                Spacer()
                SliderView(value: $width, color: $selectedColor, minWidth: 2, maxWidth: 20)
            }
            
        }
       
        
        
    }
    
    private func saveCanvasToPhotos() {
        guard canvasSize != .zero else { return }
        let screenSize = UIScreen.main.bounds.size
        if #available(iOS 16.0, *) {
            let content = DrawingCanvasView(mainGrap: mainGrap)
                        .frame(width: screenSize.width, height: screenSize.height)
            
            let renderer = ImageRenderer(content: content)
            renderer.scale = UIScreen.main.scale

            if let uiImage = renderer.uiImage {
                UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
            }
        } else {
            print("Saving not supported on iOS < 16 in this demo")
        }
    }
}

#Preview {
    ContentView()
}
