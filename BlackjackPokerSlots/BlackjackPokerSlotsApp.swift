import SwiftUI

@main
struct BlackjackPokerSlotsApp: App {
    
    @UIApplicationDelegateAdaptor(BlackjackAppPokerslotsDelegate.self) var blackjackAppPokerslotsDelegate
    
    var body: some Scene {
        WindowGroup {
            LoadingView()
        }
    }
}
