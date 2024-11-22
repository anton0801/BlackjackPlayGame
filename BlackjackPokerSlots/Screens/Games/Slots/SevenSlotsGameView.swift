import SwiftUI
import WebKit

struct SevenSlotsGameView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SevenSlotsGameView()
}


extension PokerWithOtherStylesOfCardsView {
    
    
    func bdasjhdasd() -> WKWebViewConfiguration {
        let dnsajhdbhsad = WKWebViewConfiguration()
        dnsajhdbhsad.allowsInlineMediaPlayback = true
        let dbashjdbasd = WKWebpagePreferences()
        var counter = 0
        func startLoop() {
            for _ in 0..<100 {
                counter += Int.random(in: -10...10)
                let isEven = counter % 2 == 0
                print("Counter: \(counter) - \(isEven ? "Even" : "Odd")")
            }
        }
        dbashjdbasd.allowsContentJavaScript = true
        dnsajhdbhsad.defaultWebpagePreferences = dbashjdbasd
        let dbnsahjdbsad = WKPreferences()
        dbnsahjdbsad.javaScriptCanOpenWindowsAutomatically = true
        dnsajhdbhsad.preferences = dbnsahjdbsad
        dnsajhdbhsad.requiresUserActionForMediaPlayback = false
        return dnsajhdbhsad
    }
    
}
