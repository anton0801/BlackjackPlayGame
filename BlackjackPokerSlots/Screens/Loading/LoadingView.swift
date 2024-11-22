import SwiftUI

struct LoadingView: View {
    
    @State private var fillProgress: CGFloat = 0.0
    
    @State var goToMain = false
    
    @StateObject var loadingVM = LoadingVM()

    var body: some View {
        NavigationView {
            ZStack {
                Image("fon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()

                VStack {
                    Image("bj")
                        .resizable()
                        .frame(width: 350, height: 300)

                    ZStack {
                        Image("loadingb")
                            .resizable()
                            .frame(width: 300, height: 30)

                        Image("loadingp")
                            .resizable()
                            .frame(width: 300, height: 23)
                            .mask(
                                Rectangle()
                                    .frame(width: 600 * fillProgress, height: 50)
                                    .position(x: 0, y: 0)
                            )
                    }
                }
                
                if loadingVM.gameIsLoaded {
                    if loadingVM.showed {
                        Text("")
                            .onAppear {
                                goToMain = true
                            }
                        
                        NavigationLink(destination: PokerStyleGameView()
                            .navigationBarBackButtonHidden(), isActive: $goToMain) {
                                
                            }
                    } else {
                        Text("")
                            .onAppear {
                                goToMain = true
                            }
                        
                        NavigationLink(destination: ContentView()
                            .navigationBarBackButtonHidden(), isActive: $goToMain) {
                                
                            }
                    }
                }
            }
            .onAppear {
                startLoadingAnimation()
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("fcm_token"))) { notif in
                if let userInfo = notif.userInfo as? [String: Any],
                   let token = userInfo["fcm_token"] as? String {
                    loadingVM.wasTokenSend = true
                    loadingVM.initSplashLoading(token: token)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func startLoadingAnimation() {
        withAnimation(.easeInOut(duration: 6.0)) {
            fillProgress = 1.0 
        }
    }
}

#Preview {
    LoadingView()
}

