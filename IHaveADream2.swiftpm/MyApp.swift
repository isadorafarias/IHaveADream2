import SwiftUI


@main
struct MyApp: App {
    let shared = AudioManager.shared
    @State var fontRegular: Font?
    

    
    var body: some Scene {
        WindowGroup {
            IHAD()
        }
    }
}
