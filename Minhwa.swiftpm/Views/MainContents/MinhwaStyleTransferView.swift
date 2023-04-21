//
//  SwiftUIView.swift
//  
//
//  Created by 김영빈 on 2023/04/16.
//

import SwiftUI
import CoreML
import UIKit

struct MinhwaStyleTransferView: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    let minhwaName: String
    @State private var isShowingImagePicker = false
    @State private var isShowingCameraPicker = false
    @State private var lightStrength: CGFloat = 0.35
    
    @State private var leftImage: UIImage? // 사용자 이미지
    @State private var leftWidth: CGFloat = 350
    @State private var leftHeight: CGFloat = 350
    @State private var leftRatio: CGFloat = 1
    @State private var isImageLoaded = false
    
    @State var resultImage: UIImage?
    let rightImage: UIImage
    let rightWidth: CGFloat
    let rightHeight: CGFloat
    let rightRatio: CGFloat

    
    @State private var offset: CGSize = .zero // 이미지 뷰의 위치
    @State private var dragging = false // 이미지가 드래그 중인지
    @State private var showHighlight = false // 이미지 갖다댈 시 테두리 표시
    
    @State private var isArrowAnimating = false // 화살표 애니메이션
    @State private var isStyleTransferDone = false // 스타일 전이 완료 여부
    @State private var isSaved = false // 사진 저장 여부
    @State private var isShowingActionSheet = false
    
    var script1 = "Create your own Minhwa."
    var script2 = "Choose the image you want to apply Minhwa's style to."
    var script3 = "If you use a photo with a similar concept to Minhwa of the style you want to apply,\nyou will be able to create a better picture!"
    var script4 = "My Minhwa"
    
    init(minhwaName: String) {
        self.minhwaName = minhwaName
        rightImage = UIImage(named: minhwaName)!
        rightWidth = rightImage.size.width
        rightHeight = rightImage.size.height
        rightRatio = rightWidth / rightHeight
    }
    
    var body: some View {
        VStack(alignment: .center) {
            // Description
            VStack(alignment: .center) {
                BrownText(text: script1, bold: true)
                    .font(.system(size: deviceWidth*0.03))
                    .padding(.bottom)
                BrownText(text: script2)
                    .font(.system(size: deviceWidth*0.025))
                    .padding(.bottom, 3)
                BrownText(text: script3)
                    //.font(.largeTitle)
                    .font(.system(size: deviceWidth*0.02))
                    .multilineTextAlignment(.center)
                    .frame(width: deviceWidth)
            }
            .padding()
            
            HStack(alignment: .center) {
                // User Image
                if (leftImage != nil) {
                    Image(uiImage: leftImage!)
                        .resizable()
                        .frame(
                            width: (leftHeight >= leftWidth) ? deviceHeight*0.4*leftRatio : deviceWidth*0.3,
                            height:  (leftHeight >= leftWidth) ? deviceHeight*0.4 : deviceWidth*0.3/leftRatio
                        )
                        .cornerRadius(dragging ? 10 : 0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.brown, lineWidth: dragging ? 10 : 0)
                                .opacity(dragging ? 0.5 : 0)
                                .frame(
                                    width: (leftHeight >= leftWidth) ? deviceHeight*0.4*leftRatio : deviceWidth*0.3,
                                    height:  (leftHeight >= leftWidth) ? deviceHeight*0.4 : deviceWidth*0.3/leftRatio
                                )
                        )
                        .padding()
                        .offset(offset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    print("width: \(gesture.translation.width), height: \(gesture.translation.height)")
                                    let moveLeftRight = gesture.translation.width
                                    
                                    if (moveLeftRight >= deviceWidth*0.066) {
                                        showHighlight = true
                                    } else {
                                        showHighlight = false
                                    }
                                    offset = gesture.translation
                                    dragging = true
                                }
                                .onEnded { gesture in
                                    if showHighlight == true {
                                        if minhwaName == "geumgang" {
                                            transferStyle1()
                                        } else if minhwaName == "irworobong" {
                                            transferStyle2()
                                        } else {
                                            transferStyle3()
                                        }
                                        isStyleTransferDone = true
                                    }
                                    offset = .zero
                                    dragging = false
                                }
                        )
                    
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.brown, lineWidth: 5)
                            .opacity(0.5)
                            //.frame(width: 300*leftRatio, height: 300)
                            .frame(width: deviceWidth*0.26*leftRatio, height: deviceWidth*0.26)
                        VStack(alignment: .center) {
                            MyButton(sfSymbol: "photo", symbolSize: deviceWidth*0.02, text: "Load from photo library", width: deviceWidth*0.23, height: deviceHeight*0.07, bold: true) {
                                print("Load photo from library")
                                isShowingImagePicker = true
                            }
                            .padding(.bottom, 20)
                            MyButton(sfSymbol: "camera", symbolSize: deviceWidth*0.02, text: "Load from cameara", width: deviceWidth*0.23, height: deviceHeight*0.07, bold: true) {
                                print("Load photo camera")
                                isShowingCameraPicker = true
                            }
                        }
                        // 이미지 피커 불러오기
                        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                            ImagePicker(image: $leftImage, sourceType: .photoLibrary)
                        }
                        // 카메라 피커 불러오기
                        .sheet(isPresented: $isShowingCameraPicker, onDismiss: loadImage) {
                            ImagePicker(image: $leftImage, sourceType: .camera)
                        }
                    }
                    .padding()
                }
                
                Image(systemName: dragging ? "arrowshape.right.fill" : "arrowshape.right")
                    .resizable()
                    //.frame(width: 30, height: 30)
                    .frame(width: deviceWidth*0.03, height: deviceWidth*0.03)
                    .foregroundColor(.brown)
                    .offset(x: isArrowAnimating ? 8 : -8)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
                            isArrowAnimating.toggle()
                        }
                    }
                    .animation(.easeInOut(duration: 0.6), value: isArrowAnimating)
                    .padding()
                    
                
                // Minhwa Image
                Image(minhwaName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: (rightHeight >= rightWidth) ? deviceHeight*0.3*rightRatio : deviceWidth*0.3,
                        height:  (rightHeight >= rightWidth) ? deviceHeight*0.3 : deviceWidth*0.3/rightRatio
                    )
                    .cornerRadius(showHighlight ? 10 : 0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: showHighlight ? 5 : 0)
                            .opacity(showHighlight ? 0.5 : 0)
                            .frame(
                                width: (rightHeight >= rightWidth) ? deviceHeight*0.3*rightRatio : deviceWidth*0.3,
                                height:  (rightHeight >= rightWidth) ? deviceHeight*0.3 : deviceWidth*0.3/rightRatio
                            )
                    )
                    .padding()
            }
            .padding()
            
            HStack(alignment: .center) {
                if isImageLoaded {
                    // Reload Image Button
                    MyButton(sfSymbol: "repeat", text: "Reload Image", width: deviceWidth*0.2, height: deviceHeight*0.072, bold: true) {
                        isShowingActionSheet = true
                    }
                    .actionSheet(isPresented: $isShowingActionSheet) {
                        ActionSheet(title: Text("Reload Image"),
                                    message: Text("Select how to reload image."),
                                    buttons: [
                                        .default(Text("From Library")) { isShowingImagePicker = true },
                                        .default(Text("From Camera")) { isShowingCameraPicker = true },
                                        .destructive(Text("Cancel")) {}
                                    ]
                        )
                    }
                    // 이미지 피커 불러오기
                    .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: $leftImage, sourceType: .photoLibrary)
                    }
                    // 카메라 피커 불러오기
                    .sheet(isPresented: $isShowingCameraPicker, onDismiss: loadImage) {
                        ImagePicker(image: $leftImage, sourceType: .camera)
                    }
                }
            }

        }
        // Style Transfer Result Modal
        .sheet(isPresented: $isStyleTransferDone) {
            VStack {
                Spacer()
                
                if isStyleTransferDone {
                    VStack {
                        BrownText(text: script4, bold: true)
                            .font(.system(size: deviceWidth*0.03))
                    }
                } else {
                    BrownText(text: "Style transfer is in progress...", bold: true)
                        .font(.system(size: 30))
                }
                Spacer()
                
                // Result Image
                VStack {
                    if (resultImage != nil) {
                        ZStack {
                            HanjiView(
                                originImage: resultImage!,
                                originWidth: leftWidth,
                                originHeight: leftHeight,
                                originRatio: leftRatio,
                                backgroundWidth: deviceWidth*0.3,
                                backgroundHeight: deviceWidth*0.3
                            )
                            //.blendMode(.multiply)
                            
                            RadialGradient(
                                gradient: Gradient(colors: [.clear, .white, .black]),
                                center: .center,
                                startRadius: 0,
                                //endRadius: deviceWidth*0.33
                                endRadius: deviceWidth*lightStrength
                            )
                            .opacity(0.5)
                            .cornerRadius(10)
                        }
                        .frame(width: deviceWidth*0.43, height: deviceWidth*0.35)
                        .padding()
                        .padding(.bottom, -40)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.brown, lineWidth: 2)
                                .frame(width: deviceWidth*0.3, height: deviceWidth*0.3)

                            Image(systemName: "questionmark")
                                .resizable()
                                //.frame(width: 30, height: 50)
                                .frame(width: deviceWidth*0.03, height: deviceWidth*0.03)
                                .foregroundColor(.brown)
                        }
                    }

                    
                    VStack {
                        Text("💡")
                            .font(.largeTitle)
                            .padding(.bottom, -5)
                        Slider(value: $lightStrength, in: 0...0.65, step: 0.05) {
                        } minimumValueLabel: {
                            Text("🌚")
                        } maximumValueLabel: {
                            Text("🌞")
                        }
                        .tint(.brown)
                        .frame(width: deviceWidth*0.45)
                        //Text("\(lightStrength)")
                        
                        HStack {
                            // Save Button
                            MyButton(sfSymbol: "arrow.down.to.line.circle", text: "Save", width: deviceWidth*0.15, height: deviceHeight*0.053, bold: true) {
                                print("Save image")
                                guard let image = resultImage else { return }
                                let aspectRatio = leftHeight / leftWidth
                                let desireHeight: CGFloat = leftHeight
                                let newWidth = desireHeight / aspectRatio
                                let newSize = CGSize(width: newWidth, height: desireHeight)
                                let resizedImage = UIGraphicsImageRenderer(size: newSize).image { _ in
                                    image.draw(in: CGRect(origin: .zero, size: newSize))
                                }
                                
                                UIImageWriteToSavedPhotosAlbum(resizedImage, nil, nil, nil)
                                isSaved = true
                            }
                            .padding(.trailing, 20)
                            
                            // Close Button
                            MyButton(sfSymbol: "xmark", symbolSize: 20, text: "Close", width: deviceWidth*0.15, height: deviceHeight*0.053, bold: true) {
                                isStyleTransferDone = false
                            }
                        }
                        
                    }
                    //.padding(.leading, 50)
                    .padding(.top, 30)
                    .alert(isPresented: $isSaved) {
                        Alert(title: Text("Image has been saved."))
                    }
                }
                //.padding()
                Spacer()
                
            }
            .padding()
        }
    }
    
    func loadImage() {
        guard let inputImage = leftImage else { return }
        // 이미지 불러온 뒤 처리 내용
        leftWidth = inputImage.size.width
        leftHeight = inputImage.size.height
        leftRatio = leftWidth / leftHeight
        isImageLoaded = true
    }
    
    func transferStyle1() {
        if let pickedImage = leftImage {
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
    func transferStyle2() {
        if let pickedImage = leftImage {
            let model = try! IrworobongdoStyle.init(contentsOf: IrworobongdoStyle.urlOfModelInThisBundle)

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
    func transferStyle3() {
        if let pickedImage = leftImage {
            let model = try! TigerStyle.init(contentsOf: TigerStyle.urlOfModelInThisBundle)

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

struct MinhwaStyleTransferView_Previews: PreviewProvider {
    static var previews: some View {
        MinhwaStyleTransferView(minhwaName: "geumgang")
    }
}
