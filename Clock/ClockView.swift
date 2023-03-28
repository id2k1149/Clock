//
//  ClockView.swift
//  Clock
//
//  Created by Max Franz Immelmann on 3/28/23.
//

import SwiftUI

struct ClockView: View {
    @State private var currentTime = Date()
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let lineWidth: CGFloat = size / 100
            
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: size, height: size)
                ForEach(0..<60) { tick in
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 2, height: tick % 5 == 0 ? lineWidth * 3 : lineWidth)
                        .offset(y: -size / 2 + lineWidth / 2)
                        .rotationEffect(Angle.degrees(Double(tick) / 60 * 360))
                }
                GeometryReader { geometry in
                    // Hour Hand
                    Path { path in
                        path.move(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                        path.addLine(to: CGPoint(x: geometry.size.width / 2, y: size / 3))
                    }
                    .stroke(Color.black, lineWidth: lineWidth * 3)
                    .rotationEffect(Angle.degrees(Double(Calendar.current.component(.hour, from: currentTime)) / 12 * 360 + 180))
                    .rotationEffect(Angle.degrees(Double(Calendar.current.component(.minute, from: currentTime)) / 60 * 30), anchor: .center)
                    
                    // Minute Hand
                    Path { path in
                        path.move(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                        path.addLine(to: CGPoint(x: geometry.size.width / 2, y: size / 2.5))
                    }
                    .stroke(Color.black, lineWidth: lineWidth * 2)
                    .rotationEffect(Angle.degrees(Double(Calendar.current.component(.minute, from: currentTime)) / 60 * 360 + 180), anchor: .center)
                    
                    // Second Hand
                    Path { path in
                        path.move(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                        path.addLine(to: CGPoint(x: geometry.size.width / 2, y: size / 2.2))
                    }
                    .stroke(Color.orange, lineWidth: lineWidth)
                    .rotationEffect(Angle.degrees(Double(Calendar.current.component(.second, from: currentTime)) / 60 * 360 + 180), anchor: .center)
                    
                    
                }
                .frame(width: lineWidth * 2, height: size / 2)
            }
            .frame(width: size, height: size)
            .onAppear {
                let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    currentTime = Date()
                }
                RunLoop.main.add(timer, forMode: .common)
            }
        }
    }
    
    
}
