import SwiftUI

struct TitleView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                BrownText(text: "Minhwa", bold: true)
                    .font(.system(size: 80))
                    .padding()
                
                Spacer()
                
                NavigationLink {
                    IntroductionView1()
                } label: {
                    BrownText(text: "Tap to Start")
                        .font(.title)
                        .padding()
                }
                
                Spacer()
            }
            
        }
        .navigationViewStyle(.stack)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
