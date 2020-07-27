//
//  animation.swift
//  WithYou
//
//  Created by una on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import SwiftUI

struct AnimationView: View {
    @State private var half = true
    @State private var dim = true
    @State private var iY = true
    @State private var wth = true
    @State private var hasTimeElapsed = false
    @State private var hasTimeElapsed2 = false
    @State private var hasButtom = false
    @Binding var view_swither: Int
    private func delayText() {
        // Delay of 7.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.hasTimeElapsed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.hasTimeElapsed2 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.hasButtom = true
        }
    }
    
    var body: some View {
        VStack{HStack{Text("w") .opacity(hasTimeElapsed ? 1.0 : 0.0).animation(.easeInOut(duration: 2.0))
            .offset(x: hasTimeElapsed ? 15:-25)
            .font(.system(size:60, design: .rounded)) .onAppear(perform: delayText).foregroundColor(hasTimeElapsed ? .blue:.black)
            Text("i")
                .font(.system(size:60, design: .rounded))
                .animation(.easeInOut(duration: 2.0))
                .offset(x: hasTimeElapsed ? 8:-30)
                .foregroundColor(hasTimeElapsed ? .blue:.black)
            
            
            Text("th").opacity(hasTimeElapsed ? 1.0 : 0.0)  .font(.system(size:60, design: .rounded)) .offset(x: hasTimeElapsed ? 1:-32).animation(.easeInOut(duration: 2.0))
                .foregroundColor(hasTimeElapsed ? .blue:.black)
            Text("Y") .font(.system(size:60, design: .rounded)).offset(x: hasTimeElapsed ? -13:50).animation(.easeInOut(duration: 2.0))
                .foregroundColor(hasTimeElapsed ? .blue:.black)
            Text("ou").opacity(hasTimeElapsed ? 1.0 : 0.0).offset(x: hasTimeElapsed ? -28:40).animation(.easeInOut(duration: 2.0))
                
                .font(.system(size:60, design: .rounded)) .font(.system(size:40, design: .rounded))
                .animation(.easeInOut(duration: 1.0))
                
                .foregroundColor(hasTimeElapsed ? .blue:.black)
            
        }.offset(y:hasTimeElapsed ? -40 : 60).animation(.easeInOut(duration: 1.0))
            Text("Life is better").font(.system(size:30, design: .rounded))
                .offset(y: hasTimeElapsed2 ? -40:60).foregroundColor(.orange).opacity(hasTimeElapsed2 ? 1.0 : 0.0).animation(.easeInOut(duration: 2.0))
            
            
            Button(action: {
                self.view_swither = 0
            },
                   label:{Text("Let's Start")
                    //.padding()
                    //.font(.system(size: 20, design: .rounded))
                    //.background(Color(red: 233/244, green: 233/255, blue: 1))
                    //.cornerRadius(20)}
                    .foregroundColor(.purple)
                    .font(.title)
                    .padding() 
                    .cornerRadius(40)
                    .border(Color.purple, width: 5)
            }
                
                
            ).offset(y:0).opacity(hasButtom ? 1.0:0.0)
                
                .animation(.easeInOut(duration: 1.0))
            
            
            
            
            
        }
        
        /*  Text("withYou")
         .font(.system(size:40, design: .rounded))
         .foregroundColor(.blue)
         .scaleEffect(half ? 0.3 : 1.0)
         .opacity(dim ? 0.2 : 1.0)
         .animation(.easeInOut(duration: 1.0))
         .foregroundColor(.blue)
         .onTapGesture {
         self.dim.toggle()
         self.half.toggle()
         }*/
    }
}

struct FlowerView: View {
    @State private var animate = false
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    
    var body: some View {
        ZStack {
            ForEach(0..<7) { i in
                FlowerColor(petals: self.getPetals(i), length: self.getLength(i), color: self.colors[i])
            }
            .rotationEffect(Angle(degrees: animate ? 360 : 0))
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 25.0).repeatForever()) {
                    self.animate = true
                }
            }
        }
    }
    
    func getLength(_ i: Int) -> Double {
        return 1 - (Double(i) * 1 / 7)
    }
    
    func getPetals(_ i: Int) -> Int {
        return i * 2 + 15
    }
}

struct FlowerColor: View {
    let petals: Int
    let length: Double
    let color: Color
    
    @State private var animate = false
    
    var body: some View {
        let petalWidth1 = Angle(degrees: 2)
        let petalWidth2 = Angle(degrees: 360 / Double(self.petals)) * 2
        
        return GeometryReader { proxy in
            
            ForEach(0..<self.petals) { i in
                PetalShape(angle: Angle(degrees: Double(i) * 360 / Double(self.petals)), arc: self.animate ? petalWidth1 : petalWidth2, length: self.animate ? self.length : self.length * 0.9)
                    .fill(RadialGradient(gradient: Gradient(colors: [self.color.opacity(0.2), self.color]), center: UnitPoint(x: 0.5, y: 0.5), startRadius: 0.1 * min(proxy.size.width, proxy.size.height) / 2.0, endRadius: min(proxy.size.width, proxy.size.height) / 2.0))
            }
            
        }.onAppear {
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()) {
                self.animate = true
            }
        }
    }
}

struct PetalShape: Shape {
    let angle: Angle
    var arc: Angle
    var length: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(arc.degrees, length) }
        set {
            arc = Angle(degrees: newValue.first)
            length = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let hypotenuse = Double(min(rect.width, rect.height)) / 2.0 * length
        
        let sep = arc / 2
        
        let to = CGPoint(x: CGFloat(cos(angle.radians) * Double(hypotenuse)) + center.x,
                         y: CGFloat(sin(angle.radians) * Double(hypotenuse)) + center.y)
        
        let ctrl1 = CGPoint(x: CGFloat(cos((angle + sep).radians) * Double(hypotenuse)) + center.x,
                            y: CGFloat(sin((angle + sep).radians) * Double(hypotenuse)) + center.y)
        
        let ctrl2 = CGPoint(x: CGFloat(cos((angle - sep).radians) * Double(hypotenuse)) + center.x,
                            y: CGFloat(sin((angle - sep).radians) * Double(hypotenuse)) + center.y)
        
        
        var path = Path()
        
        path.move(to: center)
        path.addQuadCurve(to: to, control: ctrl1)
        path.addQuadCurve(to: center, control: ctrl2)
        
        return path
    }
    
}
