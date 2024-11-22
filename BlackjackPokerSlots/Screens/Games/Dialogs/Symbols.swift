import SwiftUI

struct Symbols: View {
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
                    Image("symbols")
                        .resizable()
                        .frame(width: 500, height: 250)
                }
            }
        }
    }
}

#Preview {
    Symbols()
}



