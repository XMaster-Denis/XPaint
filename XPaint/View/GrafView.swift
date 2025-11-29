//
//  GrafView.swift
//  XPaint
//
//  Created by XMaster on 29.11.25.
//

import SwiftUI

struct GrafView: View {
    @ObservedObject var graf: GrafObject
    
    var body: some View {
        ForEach(graf.lines) { line in
            Path { p in
                p.addLines(line.linePathWithStartEnd)
            }
            .strokedPath(StrokeStyle(lineWidth: graf.width, lineCap: .round))
            .foregroundStyle(graf.color)
        }
    }
}
