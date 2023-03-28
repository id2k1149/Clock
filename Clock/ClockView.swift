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
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 250, height: 250)
            ForEach(0..<60) { tick in
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 2, height: tick % 5 == 0 ? 15 : 5)
                    .offset(y: -125)
                    .rotationEffect(Angle.degrees(Double(tick) / 60 * 360))
            }
            GeometryReader { geometry in
                // Hour Hand
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                    path.addLine(to: CGPoint(x: geometry.size.width / 2, y: 160))
                }
                .stroke(Color.black, lineWidth: 6)
                .rotationEffect(Angle.degrees(Double(Calendar.current.component(.hour, from: currentTime)) / 12 * 360 + 180))
                .rotationEffect(Angle.degrees(Double(Calendar.current.component(.minute, from: currentTime)) / 60 * 30), anchor: .center)
                
                // Minute Hand
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                    path.addLine(to: CGPoint(x: geometry.size.width / 2, y: 180))
                }
                .stroke(Color.black, lineWidth: 4)
                .rotationEffect(Angle.degrees(Double(Calendar.current.component(.minute, from: currentTime)) / 60 * 360 + 180), anchor: .center)
                
                // Second Hand
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                    path.addLine(to: CGPoint(x: geometry.size.width / 2, y: 200))
                }
                .stroke(Color.orange, lineWidth: 2)
                .rotationEffect(Angle.degrees(Double(Calendar.current.component(.second, from: currentTime)) / 60 * 360 + 180), anchor: .center)
                
            }
            .frame(width: 5, height: 125)
        }
        .onAppear {
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                currentTime = Date()
            }
            RunLoop.main.add(timer, forMode: .common)
        }
    }
}

struct AnalogClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
 
