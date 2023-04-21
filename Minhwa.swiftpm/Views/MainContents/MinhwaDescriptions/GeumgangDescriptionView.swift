//
//  SwiftUIView.swift
//  
//
//  Created by 김영빈 on 2023/04/16.
//

import SwiftUI

struct GeumgangDescriptionView: View {
    @State var animationFlags = [false, false, false, false, false, false, false, false]
    @State var textOpacities: [CGFloat] = [0, 0, 0, 0, 0, 0]
    @State var swipeOffset: CGFloat = 0
    @State var isScrollviewTouched = false
    
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    var script1 = "Sansuhwa was painted with the intention of viewing and appreciating the beautiful mountains and waters at home.\n"
    var script2 = "However, Sansuhwa was not painted to resemble an existing scene. It was rather created to imitate a famous artists’ paintings or to add the artist’s imagination.\nSansuhwa ignores perspective and emphasizes the main subject by portraying it larger.\nThis type of Minhwa highlights the miraculous beauty of nature."
    var script3 = "This painting is \"Geumgang jeondo\", one of the representative works of Sansuhwa.\n"
    var script4 = "Geumgang jeondo is a painting painted by a painter named \"Jeong Seon\" in the late Joseon Dynasty after seeing the beauty of Mt. Geumgang.\n\nThis painting is recognized as a masterpiece amongst Jeong Seon’s works as it was painted by looking at the actual landscape of Korea rather than looking at Chinese Sansuhwa which was more common."
    
    let minhwaImage: UIImage
    let minhwaWidth: CGFloat
    let minhwaHeight: CGFloat
    let minhwaRatio: CGFloat
    
    init() {
        minhwaImage = UIImage(named: "geumgang")!
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
                        backgroundHeight: deviceHeight*0.7
                    )
                    .padding()
                }
                
                VStack(alignment: .center) {
                    ZStack {
                        VStack(alignment: .center) {
                            LeftAlignedBrownText(text: "Sansuhwa (산수화, 山水畵))", bold: true, isTitle: true, fontSize: 40)
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
                            LeftAlignedBrownText(text: "Geumgang jeondo (금강전도)", bold: true, isTitle: true, fontSize: 35)
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
                MinhwaStyleTransferView(minhwaName: "geumgang")
            } label: {
                NextButton(isPressed: true, deviceWidth: deviceWidth, deviceHeight: deviceHeight)
            }
        }
    }
}

struct GeumgangDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        GeumgangDescriptionView()
    }
}
