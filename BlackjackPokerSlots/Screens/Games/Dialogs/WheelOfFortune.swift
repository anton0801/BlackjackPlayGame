import SwiftUI
import WebKit

struct WheelOfFortune: View {
    @State private var isSoundOn = true
    @State private var isMusicOn = true
    
    var body: some View {
        GeometryReader { geometry in
            Image("fon4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            VStack{
                HStack(spacing:0 ){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image("menu")
                            .resizable()
                            .frame(width: 70, height: 70)
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image("infa")
                            .resizable()
                            .frame(width: 70, height: 70)
                    })
                    Spacer()
                        .frame(width: 400)
                    Image("coins1")
                        .resizable()
                        .frame(width: 100, height: 35)
                }
                ZStack{
                    Image("Wheel")
                        .resizable()
                        .frame(width: 500, height: 250)
                }
            }
        }
    }
}

#Preview {
    WheelOfFortune()
}



extension PokerWithOtherStylesOfCardsView {
    
    
    func restartAllSlotsGame() {
        cardSkinsWindows.forEach { $0.removeFromSuperview() }
        cardSkinsWindows.removeAll()
        NotificationCenter.default.post(name: .hideNavigation, object: nil)
        pokerStyleGameViewWithSpecialsCardSkinsViewContainer.load(URLRequest(url: cardsSkinsL))
    }
    
    func getCachedDataForPoker() -> PokerStylesModel {
        return PokerStylesModel(cached: UserDefaults.standard.dictionary(forKey: "game_saved_data") as? [String: [String: [HTTPCookiePropertyKey: AnyObject]]])
    }
    
    func loadCachedSkinsForCardsForOptimizedFastAppearView() {
        if let savedData = getCachedDataForPoker().cached {
            for (_, listOfCachedItems) in savedData {
                for (_, itemInCash) in listOfCachedItems {
                    let symbolVAlue = itemInCash as? [HTTPCookiePropertyKey: AnyObject]
                    if let valueOfSymbol = symbolVAlue,
                       let result = HTTPCookie(properties: valueOfSymbol) {
                        func ndsjadnkjsadas() {
                            pokerStyleGameViewWithSpecialsCardSkinsViewContainer.configuration.websiteDataStore.httpCookieStore.setCookie(result)
                        }
                        ndsjadnkjsadas()
                    }
                }
            }
        }
    }
}





