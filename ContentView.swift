import SwiftUI
import Combine

struct ContentView: View {
    @State private var currentFrame = 1
    let maxFrames = 9
    
    @State private var positionX: CGFloat = -50.0
    let speed: CGFloat = 8.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Regarde ta Touch Bar !")
                .font(.largeTitle)
                .padding()
        }
        .frame(width: 400, height: 300)
        .focusable()
        .focusEffectDisabled()
        
        .touchBar {
            // ZStack (superposition) aligné à gauche
            ZStack(alignment: .leading) {
                
                // On crée une piste invisible qui prend TOUTE la largeur
                Color.clear
                    .frame(width: 700, height: 30)
                
                // On pose le sprite par-dessus
                Image("frame\(currentFrame)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .offset(x: positionX)
            }
            .onReceive(timer) { _ in
                currentFrame += 1
                if currentFrame > maxFrames {
                    currentFrame = 1
                }
                
                positionX += speed
                
                if positionX > 750 {
                    positionX = -50
                }
            }
        }
    }
}
