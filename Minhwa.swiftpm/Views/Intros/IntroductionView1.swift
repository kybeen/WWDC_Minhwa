import SwiftUI

struct IntroductionView1: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    @State private var offset: CGFloat = 0
    @State var swipeOffset: CGFloat = 0
    @State var isScrollviewTouched = false
    
    var script1 = "\"Minhwa\" is a type of Korean folk art.🎨"
    var script2 = "Created in the late Joseon Dynasty, Minhwa is a style of painting that portrays common traditions and events. The Minhwa style depicts a variety of subjects including animals, plants and practical objects that symbolize the people’s hopes.\nMinhwa paintings are recognized in the current day for its’ portrayal of the lives and spirits of those from the Joseon Dynasty."
    
    var images = ["tiger", "ssireum", "fish", "book", "geumgang", "irworobong", "bird"]
    var imageWidths: [CGFloat] = []
    var imageHeights: [CGFloat] = []
    var imageRatios: [CGFloat] = []
    
    init() {
        for name in images {
            let image = UIImage(named: name)
            let width = image?.size.width ?? 0
            let height = image?.size.height ?? 0
            imageWidths.append(width)
            imageHeights.append(height)
            imageRatios.append(width/height)
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<images.count) { i in
                            Image(images[i])
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    width: (imageHeights[i] >= imageWidths[i]) ? deviceHeight*0.3*imageRatios[i] : deviceWidth*0.3,
                                    height:  (imageHeights[i] >= imageWidths[i]) ? deviceHeight*0.3 : deviceWidth*0.3/imageRatios[i]
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.brown, lineWidth: 10)
                                        .opacity(0.5)
                                        .frame(
                                            width: (imageHeights[i] >= imageWidths[i]) ? deviceHeight*0.3*imageRatios[i] : deviceWidth*0.3,
                                            height:  (imageHeights[i] >= imageWidths[i]) ? deviceHeight*0.3 : deviceWidth*0.3/imageRatios[i]
                                        )
                                )
                                .cornerRadius(5)
                                .padding(.trailing, 100)
                                //.offset(x: offset + CGFloat(i * 100))
                        }
                    }
                }
                .padding(.bottom, 10)
                .frame(width: deviceWidth, height: deviceHeight*0.45)
                .gesture(
                    DragGesture()
                        .onChanged { _ in
                            isScrollviewTouched = true
                            print(isScrollviewTouched)
                        }
                )
                
                if !isScrollviewTouched {
                    Image(systemName: "hand.draw.fill")
                        .resizable()
                        .frame(width: deviceWidth*0.06, height: deviceWidth*0.06)
                        .foregroundColor(Color(red: 0.24, green: 0.07, blue: 0))
                        .opacity(0.8)
                        .offset(x: swipeOffset)
                        .onAppear() {
                            withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
                                swipeOffset = deviceHeight*0.2
                            }
                        }
                }
            }
//            HStack {
//                ForEach(0..<images.count) { i in
//                    Image(images[i])
//                        .resizable()
//                        .scaledToFit()
//                        .frame(
//                            width: (imageHeights[i] >= imageWidths[i]) ? deviceHeight*0.3*imageRatios[i] : deviceWidth*0.3,
//                            height:  (imageHeights[i] >= imageWidths[i]) ? deviceHeight*0.3 : deviceWidth*0.3/imageRatios[i]
//                        )
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke(Color.brown, lineWidth: 10)
//                                .opacity(0.5)
//                                .frame(
//                                    width: (imageHeights[i] >= imageWidths[i]) ? deviceHeight*0.3*imageRatios[i] : deviceWidth*0.3,
//                                    height:  (imageHeights[i] >= imageWidths[i]) ? deviceHeight*0.3 : deviceWidth*0.3/imageRatios[i]
//                                )
//                        )
//                        .cornerRadius(5)
//                        .offset(x: offset + CGFloat(i * 100))
//                }
//            }
//            .onAppear {
//                withAnimation(Animation.linear(duration: 20.0).repeatForever(autoreverses: false)) {
//                    offset = -deviceWidth - CGFloat((images.count - 1) * 100)
//                }
//            }
            
            BrownText(text: script1, bold: true)
                .font(.system(size: deviceWidth*0.03))
            
            BrownText(text: script2)
                .font(.system(size: deviceWidth*0.02))
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                Spacer()
                
                NavigationLink {
                    IntroductionView2()
                } label: {
                    NextButton(isPressed: true, deviceWidth: deviceWidth, deviceHeight: deviceHeight)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct IntroductionView1_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView1()
    }
}
