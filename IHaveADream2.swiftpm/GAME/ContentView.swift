import SwiftUI

struct ContentView: View {
    
    @State private var currentTime: Double = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let roundTime: Double = 10
    var body: some View {
        VStack {
            SwiftUI.ProgressView (value: max (0, roundTime - currentTime), total: roundTime)
                .onReceive(timer) { _ in
                    if currentTime < roundTime {
                        currentTime += 0.1
                            
                    }
                }
                .scaleEffect(y:10)
            Spacer ()
        }
//      .padding()
        .ignoresSafeArea()
    }
}
#Preview {
    ContentView()
}

