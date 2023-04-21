//
//  SwiftUIView.swift
//  
//
//  Created by 김영빈 on 2023/04/18.
//

import SwiftUI

struct HanjiView: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    
    let originImage: UIImage
    let originWidth: CGFloat
    let originHeight: CGFloat
    let originRatio: CGFloat
    
    var backgroundWidth: CGFloat
    var backgroundHeight: CGFloat
    //var imageSize: CGFloat
    
//    init() {
//        originImage = UIImage(named: "sample")!
//        originWidth = originImage.size.width
//        originHeight = originImage.size.height
//        originRatio = originWidth / originHeight
//
//        backgroundSize = 400
//        imageSize = 300
//    }
    
    var body: some View {
        ZStack {
            Image("paperboardTexture")
                .resizable()
                //.frame(width: 600, height: 600)
                .frame(width: backgroundWidth, height: backgroundHeight)
                .shadow(radius: 10)
            
            Image(uiImage: originImage)
                .resizable()
                //.frame(width: 500*originRatio, height: 500)
                //.frame(width: imageSize*originRatio, height: imageSize)
                .frame(
                    width: (originHeight >= originWidth) ? deviceHeight*0.35*originRatio : deviceWidth*0.25,
                    height:  (originHeight >= originWidth) ? deviceHeight*0.35 : deviceWidth*0.25/originRatio
                )
                .scaledToFit()
                .shadow(radius: 10)
        }
//        .blur(radius: 10)
    }
}

//struct HanjiView_Previews: PreviewProvider {
//    static var previews: some View {
//        HanjiView(
//            originImage: UIImage(named: "sample")!,
//            originRatio: 2/3,
//            backgroundWidth: 400,
//            backgroundHeight: 400,
//            imageSize: 400
//        )
////        HanjiView()
//    }
//}
