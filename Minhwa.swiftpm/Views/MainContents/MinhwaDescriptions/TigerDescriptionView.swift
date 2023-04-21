//
//  SwiftUIView.swift
//  
//
//  Created by 김영빈 on 2023/04/16.
//

import SwiftUI

struct TigerDescriptionView: View {
    //@State var animationFlags = [false, false, false, false, false, false, false]
    @State var animationFlags = [false, false, false, false, false]
    @State var textOpacities: [CGFloat] = [0, 0, 0]
    @State var swipeOffset: CGFloat = 0
    @State var isScrollviewTouched = false
    
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    var script1 = "Hojakdo is a humorous painting of a magpie and a tiger against a background of pine trees.\n"
    var script2 = "Tigers appearing in Hojakdo usually have funny and humorous expressions, so you can feel the old people's affinity for tigers.\n\nIn Hojakdo, the king of animals, the tiger, is humorously portrayed to bring down the authority of the stronger, showing social satire.\nConversely, the magpie, a relatively weak animal, is portrayed with dignity, and we can see the phase of the late Joseon Dynasty, when the status system gradually collapsed and the status of the common people increased."
    
    let minhwaImage: UIImage
    let minhwaWidth: CGFloat
    let minhwaHeight: CGFloat
    let minhwaRatio: CGFloat
    
    init() {
        minhwaImage = UIImage(named: "tiger")!
        minhwaWidth = minhwaImage.size.width
        minhwaHeight = minhwaImage.size.height
        minhwaRatio = minhwaWidth / minhwaHeight
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                if animationFlags[0] {
                    HanjiView(
                        originImage: minhwaImage,
                        originWidth: minhwaWidth,
                        originHeight: minhwaHeight,
                        originRatio: minhwaRatio,
                        backgroundWidth: deviceWidth*0.3,
                        backgroundHeight: deviceHeight*0.6
                    )
                    .padding()
                }
                
                ZStack {
                    VStack(alignment: .center) {
                        LeftAlignedBrownText(text: "Hojakdo (호작도, 虎鵲圖)", bold: true, isTitle: true, fontSize: 40)
                            .padding(.bottom, 15)
                            .opacity(textOpacities[0])
                        ScrollView {
                            LeftAlignedBrownText(text: script1, bold: true)
                                .opacity(textOpacities[1])
                            LeftAlignedBrownText(text: script2)
                                .opacity(textOpacities[2])
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { _ in
                                    isScrollviewTouched = true
                                    print(isScrollviewTouched)
                                }
                        )
                    }
                    HStack {
                        Spacer()

                        if animationFlags[4] && !isScrollviewTouched {
                            Image(systemName: "hand.draw.fill")
                                .resizable()
                                .frame(width: deviceWidth*0.06, height: deviceWidth*0.06)
                                //.foregroundColor(Color(red: 0.24, green: 0.07, blue: 0))
                                .foregroundColor(.brown)
                                .opacity(0.8)
                                .offset(y: swipeOffset)
                                .onAppear() {
                                    withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
                                        swipeOffset = deviceHeight*0.2
                                    }
                                }
                        }
                    }
                }
                .frame(width: deviceWidth*0.6, height: deviceHeight*0.4)
                .padding()
            }
            .padding()
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    animationFlags[0] = true
                }
                withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
                    animationFlags[1] = true
                    textOpacities[0] = 1
                }
                withAnimation(.easeInOut(duration: 0.5).delay(1.0)) {
                    animationFlags[2] = true
                    textOpacities[1] = 1
                }
                withAnimation(.easeInOut(duration: 0.5).delay(1.5)) {
                    animationFlags[3] = true
                    textOpacities[2] = 1
                }
                withAnimation(.easeInOut(duration: 0.5).delay(2.5)) {
                    animationFlags[4] = true
                }
            }
            
            NavigationLink {
                MinhwaStyleTransferView(minhwaName: "tiger")
            } label: {
                NextButton(isPressed: true, deviceWidth: deviceWidth, deviceHeight: deviceHeight)
            }
        }
    }
}

struct TigerDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        TigerDescriptionView()
    }
}
