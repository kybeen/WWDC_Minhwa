import SwiftUI

struct IntroductionView2: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    @State var animationFlags = [false, false, false, false, false]
    
    var script1 = "In this app, we would like to introduce Minhwa, a kind of wonderful traditional painting in Korea, in an easy and fun way through an AI technology called Style Transfer.🤖"
    var script2 = "Style Transfer is a machine learning technique that applies the visual style of a reference image to another image or video. We will now use Style Transfer to create our own Minhwa-style painting! 🤩"
    
    
    var body: some View {
        VStack {
            
            BrownText(text: script1)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                if animationFlags[0] {
                    VStack {
                        Text("Content target")
                            .font(.title2)
                        Image("ex1")
                            .resizable()
                            .frame(width: deviceWidth*0.186, height: deviceHeight*0.203)
                    }
                }
                
                if animationFlags[1] {
                    Text("+")
                        .font(.largeTitle)
                        .padding()
                }
                
                if animationFlags[2] {
                    VStack {
                        Text("Style reference")
                            .font(.title2)
                        Image("ex2")
                            .resizable()
                            .frame(width: deviceWidth*0.186, height: deviceHeight*0.203)
                    }
                }
                
                
                if animationFlags[3] {
                    Text("=")
                        .font(.largeTitle)
                        .padding()
                }
                
                if animationFlags[4] {
                    VStack {
                        Text("Combination image")
                            .fontWeight(.bold)
                            .font(.title2)
                        Image("ex3")
                            .resizable()
                            .frame(width: deviceWidth*0.186, height: deviceHeight*0.203)
                    }
                }
            }
            .padding()
            
            BrownText(text: script2)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                Spacer()
                
                NavigationLink {
                    ExperienceView()
                } label: {
                    NextButton(isPressed: true, deviceWidth: deviceWidth, deviceHeight: deviceHeight)
                }
            }
            .padding()
            
        }
        //.navigationBarHidden(true)
        .padding()
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                animationFlags[0] = true
            }
            withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
                animationFlags[1] = true
            }
            withAnimation(.easeInOut(duration: 0.5).delay(1.5)) {
                animationFlags[2] = true
            }
            withAnimation(.easeInOut(duration: 0.5).delay(2)) {
                animationFlags[3] = true
            }
            withAnimation(.easeInOut(duration: 0.5).delay(3)) {
                animationFlags[4] = true
            }
        }
    }
}

struct IntroductionView2_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView2()
    }
}
