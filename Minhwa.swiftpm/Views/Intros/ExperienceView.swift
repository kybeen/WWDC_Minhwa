import SwiftUI
import CoreML
import UIKit

struct ExperienceView: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    
    @State var resultImage: UIImage?
    let originImage: UIImage
    let originWidth: CGFloat
    let originHeight: CGFloat
    let originRatio: CGFloat
    let rightImage: UIImage
    let rightWidth: CGFloat
    let rightHeight: CGFloat


    @State private var isArrowAnimating = false // 화살표 애니메이션
    @State private var offset: CGSize = .zero // 이미지 뷰의 위치
    @State private var dragging = false // 이미지가 드래그 중인지
    @State private var showHighlight = false // 이미지 갖다댈 시 테두리 표시
//    @State private var rightImagePoint: CGPoint = .zero
    @State private var isSampleDone = false // 샘플 이미지 스타일 전이 해봤는지 여부
    @State private var isSaved = false // 사진 저장 여부
    @State private var nextButtonVisible = false
    
    var script1 = "Before we begin, let’s create one Minhwa painting together."
    var script2 = "Create your own minhwa by dragging the sample image on the left to the minhwa image on the right!"
    var script3 = "Excellent!🥳"
    var script3_1 = "We have made our own original Minhwa!"
    var script4 = "You can also save it to your gallery if you want."
    var script5 = "Now, let's go make our own minhwa!"
    
    init() {
        originImage = UIImage(named: "sample")!
        originWidth = originImage.size.width
        originHeight = originImage.size.height
        originRatio = originWidth / originHeight
        
        rightImage = UIImage(named: "geumgang")!
        rightWidth = rightImage.size.width
        rightHeight = rightImage.size.height
    }
    
    var body: some View {
        VStack {
            // Description
            VStack {
                BrownText(text: script1, bold: true)
                    .font(.largeTitle)
                    .padding()
                    .padding(.bottom)
                BrownText(text: script2)
                    .font(.system(size: deviceWidth*0.03))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            // Style Transfer Sample
            HStack {
                // Sample Image
                Image("sample")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width*0.313, height: UIScreen.main.bounds.height*0.224)
                    .cornerRadius(dragging ? 10 : 0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.brown, lineWidth: dragging ? 10 : 0)
                            .opacity(dragging ? 0.5 : 0)
                            .frame(width: UIScreen.main.bounds.width*0.313, height: UIScreen.main.bounds.height*0.224)
                    )
                    .padding()
                    .offset(offset)
                    .gesture(
                        // 이미지 뷰를 그래그할 때 호출되는 핸들러 - DragGseture는 translation 값을 반환하므로 이 값을 사용하여 이미지 뷰의 위치를 업데이트합니다.
                        DragGesture()
                            .onChanged { gesture in
                                print("width: \(gesture.translation.width), height: \(gesture.translation.height)")
                                let moveLeftRight = gesture.translation.width
                                //let moveUpDown = gesture.translation.height
                                
                                if (moveLeftRight >= deviceWidth*0.066) {
                                    showHighlight = true
                                } else {
                                    showHighlight = false
                                }
                                offset = gesture.translation
                                dragging = true
                            }
                            .onEnded { gesture in
                                //offset = gesture.translation
                                if showHighlight == true {
                                    transferStyle()
                                    isSampleDone = true
                                    nextButtonVisible = true
                                }
                                offset = .zero
                                dragging = false
                            }
                    )
                
                Image(systemName: dragging ? "arrowshape.right.fill" : "arrowshape.right")
                    .resizable()
                    .frame(width: deviceWidth*0.03, height: deviceWidth*0.03)
                    .foregroundColor(.brown)
                    .offset(x: isArrowAnimating ? 8 : -8)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
                            isArrowAnimating.toggle()
                        }
                    }
                    .animation(.easeInOut(duration: 0.6), value: isArrowAnimating)
                    
                
                // Sample Minhwa Image
                Image("geumgang")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width*0.186, height: UIScreen.main.bounds.height*0.376)
                    .cornerRadius(showHighlight ? 10 : 0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: showHighlight ? 5 : 0)
                            .opacity(showHighlight ? 0.5 : 0)
                            .frame(width: UIScreen.main.bounds.width*0.186, height: UIScreen.main.bounds.height*0.376)
                    )
                    .padding()
            }
            .padding()
            .padding(.bottom, 50)
            
            if nextButtonVisible {
                // Next Button
                NavigationLink {
                    SelectMinhwaView()
                } label: {
                    NextButton(isPressed: true, deviceWidth: deviceWidth, deviceHeight: deviceHeight)
                }
                .padding(.top, -50)
            }

        }
        //.navigationBarHidden(true)
        // Style Transfer Result Modal
        .sheet(isPresented: $isSampleDone) {
            VStack {
                Spacer()
                
                if isSampleDone {
                    VStack {
                        BrownText(text: script3, bold: true)
                            .font(.system(size: 30))
                        BrownText(text: script3_1, bold: true)
                            .font(.system(size: 25))
                            .padding(.bottom, 5)
                        BrownText(text: script4)
                            .font(.title2)
                        BrownText(text: script5)
                            .font(.title2)
                    }
                } else {
                    BrownText(text: "Style transfer is in progress...", bold: true)
                        .font(.system(size: 30))
                }
                Spacer()
                
                // Result Image
                VStack {
                    if (resultImage != nil) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(.brown, lineWidth: 2)
//                                .frame(width: 200*originRatio, height: 200)
////                                .frame(
////                                    width: (originWidth>=originHeight) ? originWidth : originHeight,
////                                    height: (originWidth>=originHeight) ? originWidth : originHeight
////                                )
//
//                            Image(uiImage: resultImage!)
//                                .resizable()
//                                //.frame(width: originWidth, height: originHeight)
//                                .frame(width: 200*originRatio, height: 200)
//                                .scaledToFit()
//                                .cornerRadius(10)
//                        }
                        
//                        HanjiView(
//                            originImage: resultImage!,
//                            originRatio: originRatio,
//                            backgroundWidth: deviceWidth*0.3,
//                            backgroundHeight: deviceWidth*0.3,
//                            imageSize: deviceWidth*0.13
//                        )
                        HanjiView(
                            originImage: resultImage!,
                            originWidth: originWidth,
                            originHeight: originHeight,
                            originRatio: originRatio,
                            backgroundWidth: deviceWidth*0.3,
                            backgroundHeight: deviceWidth*0.3
                        )
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.brown, lineWidth: 2)
                                .frame(width: 300, height: 300)

                            Image(systemName: "questionmark")
                                .resizable()
                                .frame(width: 30, height: 50)
                                .foregroundColor(.brown)
                        }
                    }

                    
                    VStack {
                        // Save Button
                        MyButton(sfSymbol: "arrow.down.to.line.circle", text: "Save", width: deviceWidth*0.15, height: 45, bold: true) {
                            print("Save image")
                            guard let image = resultImage else { return }
                            let aspectRatio = originHeight / originWidth
                            let desireHeight: CGFloat = originHeight
                            let newWidth = desireHeight / aspectRatio
                            let newSize = CGSize(width: newWidth, height: desireHeight)
                            let resizedImage = UIGraphicsImageRenderer(size: newSize).image { _ in
                                image.draw(in: CGRect(origin: .zero, size: newSize))
                            }
                            
                            UIImageWriteToSavedPhotosAlbum(resizedImage, nil, nil, nil)
                            isSaved = true
                        }
                        
                        // Close Button
                        MyButton(sfSymbol: "xmark", symbolSize: 20, text: "Close", width: deviceWidth*0.15, height: 45, bold: true) {
                            isSampleDone = false
                        }
                        
                    }
                    .padding(.top, 30)
                    .alert(isPresented: $isSaved) {
                        Alert(title: Text("Image has been saved."))
                    }
                    
                }
                Spacer()
                
            }
        }
    }
    
    func transferStyle() {
        if let pickedImage = UIImage(named: "sample") {

            let model = try! GeumgangStyle.init(contentsOf: GeumgangStyle.urlOfModelInThisBundle)

            if let image = pixelBuffer(from: pickedImage) {
                do {
                    let predictionOutput = try model.prediction(image: image)

                    let ciImage = CIImage(cvPixelBuffer: predictionOutput.stylizedImage)
                    let tempContext = CIContext(options: nil)
                    let tempImage = tempContext.createCGImage(ciImage, from: CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(predictionOutput.stylizedImage), height: CVPixelBufferGetHeight(predictionOutput.stylizedImage)))
                    resultImage = UIImage(cgImage: tempImage!)
                    
                } catch let error as NSError {
                    print("CoreML Model Error: \(error)")
                }
            }
        }
    }
}

func pixelBuffer(from image: UIImage) -> CVPixelBuffer? {
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 512, height: 512), true, 2.0)
    image.draw(in: CGRect(x: 0, y: 0, width: 512, height: 512))
    _ = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()

    let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
    var pixelBuffer : CVPixelBuffer?
    let status = CVPixelBufferCreate(kCFAllocatorDefault, 512, 512, kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
    guard (status == kCVReturnSuccess) else {
        return nil
    }

    CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
    let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    let context = CGContext(data: pixelData, width: 512, height: 512, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

    context?.translateBy(x: 0, y: 512)
    context?.scaleBy(x: 1.0, y: -1.0)

    UIGraphicsPushContext(context!)
    image.draw(in: CGRect(x: 0, y: 0, width: 512, height: 512))
    UIGraphicsPopContext()
    CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

    return pixelBuffer
}

struct ExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceView()
    }
}
