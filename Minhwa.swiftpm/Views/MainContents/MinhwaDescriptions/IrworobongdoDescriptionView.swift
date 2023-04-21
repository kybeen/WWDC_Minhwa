//
//  SwiftUIView.swift
//  
//
//  Created by 김영빈 on 2023/04/16.
//

import SwiftUI

struct IrworobongdoDescriptionView: View {
    @State var animationFlags = [false, false, false, false, false, false, false, false]
    @State var textOpacities: [CGFloat] = [0, 0, 0, 0, 0, 0]
    @State var swipeOffset: CGFloat = 0
    @State var isScrollviewTouched = false
    
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    var script1 = "Jangsaengdo is a symbolic painting that compares the desire to live a long and happy life to nature and animals and plants.\n"
    var script2 = "Jangsaengdo portrays subject matter that symbolize longevity including the sun, moon, pine trees, etc.\nThey were typically made into a folding screen or as a decorative closet door. Because of its’ complexity many were created collectively by numerous painters.\n\nIn addition, most of the works were produced for the royal court, and the materials for the paintings are good and the workmanship is excellent."
    var script3 = "This painting is \"Irworobongdo\", a painting placed on the back of the royal family in the palace during the Joseon Dynasty.\n"
    var script4 = "Irworobongdo is a painting depicting five mountain peaks, the sun and the moon, and is evaluated as a representative painting of the court, symbolizing the existence of the king in the late Joseon Dynasty."
    
    let minhwaImage: UIImage
    let minhwaWidth: CGFloat
    let minhwaHeight: CGFloat
    let minhwaRatio: CGFloat
    
    init() {
        minhwaImage = UIImage(named: "irworobong")!
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
                        backgroundWidth: deviceWidth*0.33,
                        backgroundHeight: deviceHeight*0.5
                    )
                    .padding()
                }
                
                VStack(alignment: .center) {
                    ZStack {
                        VStack(alignment: .center) {
                            LeftAlignedBrownText(text: "Jangsaengdo (장생도, 長生圖)", bold: true, isTitle: true, fontSize: 40)
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
                            
                            if animationFlags[3] && !isScrollviewTouched {
                                Image(systemName: "hand.draw.fill")
                                    .resizable()
                                    .frame(width: deviceWidth*0.06, height: deviceWidth*0.06)
                                    .foregroundColor(.brown)
                                    .opacity(0.8)
                                    .offset(y: swipeOffset)
                                    .onAppear() {
                                        withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
                                            swipeOffset = deviceHeight*0.15
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 15)
                    
                    ZStack {
                        VStack(alignment: .center) {
                            LeftAlignedBrownText(text: "Irworobongdo (일월오봉도)", bold: true, isTitle: true, fontSize: 35)
                                .padding(.bottom, 15)
                                .opacity(textOpacities[3])
                            ScrollView {
                                LeftAlignedBrownText(text: script3, bold: true)
                                    .opacity(textOpacities[4])
                                LeftAlignedBrownText(text: script4)
                                    .opacity(textOpacities[5])
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
                            
                            if animationFlags[7] && !isScrollviewTouched {
                                Image(systemName: "hand.draw.fill")
                                    .resizable()
                                    .frame(width: deviceWidth*0.06, height: deviceWidth*0.06)
                                    .foregroundColor(.brown)
                                    .opacity(0.8)
                                    .offset(y: swipeOffset)
                                    .onAppear() {
                                        withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
                                            swipeOffset = deviceHeight*0.15
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                }
                .frame(width: deviceWidth*0.6, height: deviceHeight*0.7)
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
                    textOpacities[3] = 1
                }
                withAnimation(.easeInOut(duration: 0.5).delay(3.0)) {
                    animationFlags[5] = true
                    textOpacities[4] = 1
                }
                withAnimation(.easeInOut(duration: 0.5).delay(3.5)) {
                    animationFlags[6] = true
                    textOpacities[5] = 1
                }
                withAnimation(.easeInOut(duration: 0.5).delay(4.0)) {
                    animationFlags[7] = true
                }
            }
            
            NavigationLink {
                MinhwaStyleTransferView(minhwaName: "irworobong")
            } label: {
                NextButton(isPressed: true, deviceWidth: deviceWidth, deviceHeight: deviceHeight)
            }
        }
    }
}

struct IrworobongdoDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        IrworobongdoDescriptionView()
    }
}
