import SwiftUI

struct SelectMinhwaView: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    
    @State var animationFlags = [false, false, false]
    let names = ["geumgang", "irworobong", "tiger"]
    var minhwasWidth: [CGFloat] = []
    var minhwasHeight: [CGFloat] = []
    var minhwasRatio: [CGFloat] = []
    
    var script1 = "We have prepared three famous examples."
    var script2_1 = "The three pictures below are Minhwa in the categories"
    var script2_2 = "\"Sansuhwa\", \"Jangsaengdo\", and \"Hojakdo\""
    var script2_3 = ", respectively."
    var script3 = "You can read a description of the Minhwa and create your own in its’ style by selecting it."
    
    let minhwaNames = ["geumgang" ,"irworobong", "tiger"]
    
    init() {
        for name in names {
            let image = UIImage(named: name)
            let width = image?.size.width ?? 0
            let height = image?.size.height ?? 0
            minhwasWidth.append(width)
            minhwasHeight.append(height)
            minhwasRatio.append(width/height)
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                BrownText(text: script1, bold: true)
                    .font(.system(size: deviceWidth*0.03))
                    .multilineTextAlignment(.center)
                    .frame(width: deviceWidth)
                    .padding()
                BrownText(text: script2_1)
                    .font(.system(size: deviceWidth*0.023))
                    .multilineTextAlignment(.center)
                Text(script2_2)
                    .italic()
                    .font(.title)
                    .foregroundColor(Color(red: 165/255, green: 108/255, blue: 57/255))
                    .fontWeight(.bold)
                BrownText(text: script2_3)
                    .font(.system(size: deviceWidth*0.023))
                    .multilineTextAlignment(.center)
                BrownText(text: script3)
                    .font(.system(size: deviceWidth*0.023))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding()
            
            HStack {
                ForEach(0..<minhwaNames.count) { i in
                    NavigationLink {
                        switch i {
                        case 0:
                            GeumgangDescriptionView()
                        case 1:
                            IrworobongdoDescriptionView()
                        default:
                            TigerDescriptionView()
                        }
                    } label: {
                        if animationFlags[i] {
                            Image(minhwaNames[i])
                                .resizable()
                                .scaledToFit()
                                //.frame(width: 350*minhwasRatio[i], height: 350)
                                .frame(width: deviceHeight*0.40*minhwasRatio[i], height: deviceHeight*0.40)
                                .border(.brown, width: 5)
                                .cornerRadius(10)
                                .padding()
                        }
                    }
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    animationFlags[0] = true
                }
                withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
                    animationFlags[1] = true
                }
                withAnimation(.easeInOut(duration: 0.5).delay(1.0)) {
                    animationFlags[2] = true
                }
            }
            
        }
        //.navigationBarHidden(true)
    }
}

struct SelectMinhwaView_Previews: PreviewProvider {
    static var previews: some View {
        SelectMinhwaView()
    }
}
