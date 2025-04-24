import SwiftUI

struct ContentView: View {
    @State private var hungerLevel = 5
    @State private var happinessLevel = 8
    @State private var energyLevel = 7
    // Add above body:
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    

    // Add inside ContentView struct:
    struct ActionButton: View {
        let label: String
        let emoji: String
        let color: Color
        
        var body: some View {
            HStack {
                Text(emoji)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.black)

                Text(label)
            }
            .padding()
            .background(color.opacity(0.2))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color, lineWidth: 2)
            )

        }
    }

    var body: some View {
        ZStack {
            // 1. Background
            Image("CAMP GROUND")
                .resizable()
                .ignoresSafeArea()
            
            // 2. Pet
            Image("BLAst")
                .resizable()
                .frame(width: 200, height: 200)
            
            // 3. Stats
            VStack(alignment: .leading){
            
                Text("Hunger: \(hungerLevel)/10")
                .font(.headline)
                Text("Happiness:  \(happinessLevel) /10")
                .font(.headline)
                Text("Energy: \(energyLevel)/10")
                .font(.headline)
                Spacer()
            }.padding(15)
            .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white.opacity(0.8))
                        .shadow(radius: 5)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // Stick to top-left
            .padding(.top, 40) // Add space from top
            .padding(.leading, 20)
            

             
            
            
            // 4. Buttons
            VStack {
                Spacer()
                // Update your button HStack:
              
                HStack(spacing: 25) {
                    Button {
                        hungerLevel = min(hungerLevel + 1, 10)
                    } label: {
                        ActionButton(label: "Feed", emoji: "🍎", color: Color.red)
                    }
                    
                    
                    Button {
                        happinessLevel = min(happinessLevel + 1, 10)
                    } label: {
                        ActionButton(label: "Play", emoji: "🎾", color: Color.blue)
                    }
                    
                    Button {
                        energyLevel = min(energyLevel + 1, 10)
                    } label: {
                        ActionButton(label: "Nap", emoji: "😴", color: Color.green)
                    }
                    
                }.padding(.vertical, 15)
                    .padding(.horizontal, 25)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.85))
                    )
                    .shadow(radius: 5)
                


                
            }
        }.onReceive(timer) { _ in
            let randomStat = Int.random(in: 0...2)
            
            switch randomStat {
            case 0: hungerLevel = max(hungerLevel - 1, 0)
            case 1: happinessLevel = max(happinessLevel - 1, 0)
            default: energyLevel = max(energyLevel - 1, 0)
            }
        }
    }
}

