//
//  ContentView.swift
//  Mob Final
//
//  Created by Jennalyn Kabiling
//

import SwiftUI


enum ColorOption {
    case red, orange, yellow, green, blue, purple
    
    var textColor: Color {
        switch self {
        case .red:
            return .red
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .blue:
            return .blue
        case .purple:
            return .purple
        }
    }
    
    var text: String {
        switch self {
        case .red:
            return "red"
        case .orange:
            return "orange"
        case .yellow:
            return "yellow"
        case .green:
            return "green"
        case .blue:
            return "blue"
        case .purple:
            return "purple"
        }

    }
    
    init() {
        self = ColorOption.allCases[Int(arc4random_uniform(UInt32(ColorOption.allCases.count)))]
    }
    
}

extension ColorOption: CaseIterable {
    mutating func getRandomColor() {
        self = ColorOption.allCases[Int(arc4random_uniform(UInt32(ColorOption.allCases.count)))]
    }
}

struct ContentView: View {
    
    @State var upperColor = ColorOption()
    @State var bottomColor = ColorOption()
    @State var displayColor = ColorOption()
    
    @State var answer: Bool = false
    @State var score: Int = 0
    
    @State var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            HStack{
                Text("Time reamining \(timeRemaining)")
                            .onReceive(timer) { _ in
                                if self.timeRemaining > 0 {
                                    self.timeRemaining -= 1
                                }
                            }
                Text("Score: \(score)")
                
            }
            
            Text("Does the meaning match the text color?")
                .padding()
            
            VStack{
                Text("Meaning")
                    .font(.caption)
                Text("\(upperColor.text)")
                    .font(.largeTitle)
            }.padding()
            
            VStack{
                Text("\(displayColor.text)")
                    .font(.largeTitle)
                    .foregroundColor(bottomColor.textColor)
                Text("Text Color")
                    .font(.caption)
            }.padding()
            
            HStack{
                Group {
                    Button(action: {
                        answer = false
                        checkAnswer()
                    }) {
                        Text("NO")
                            .padding()
                            .foregroundColor(.white)
                    }
                }
                .background(Color(red: 152/255, green: 172/255, blue: 248/255))
                .padding()
                
                Group {
                    Button(action: {
                        answer = true
                        checkAnswer()
                    }) {
                        Text("YES")
                            .padding()
                            .foregroundColor(.white)
                    }
                }
                .background(Color(red: 152/255, green: 172/255, blue: 248/255))
                .padding()
            }.padding()
            Button(action: {
                reloadGame()
            }) {
                Text("RESTART")
                    .padding()
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color(red: 152/255, green: 172/255, blue: 248/255))
        }
    }
    
    func checkAnswer(){
        if timeRemaining > 0 {
            if upperColor == bottomColor && answer{
                score += 10
            }else if upperColor != bottomColor && !answer{
                score += 10
            }else if upperColor != bottomColor && answer{
                if score > 0{
                    score -= 10
                }
            }else if upperColor == bottomColor && !answer{
                if score > 0 {
                    score -= 10
                }
            }
            reloadColors()
        }
    }
    
    func reloadColors(){
        upperColor = ColorOption()
        bottomColor = ColorOption()
        displayColor = ColorOption()
    }
    
    func reloadGame(){
        timeRemaining = 60
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
