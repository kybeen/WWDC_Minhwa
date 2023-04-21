import SwiftUI

struct NextButton: View {
    var isPressed: Bool
    var deviceWidth: CGFloat
    var deviceHeight: CGFloat
    
    var body: some View {
        if isPressed {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.brown)
                    .frame(width: deviceWidth*0.08, height: deviceHeight*0.065)
                Image(systemName: "arrowshape.right.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.brown, lineWidth: 2)
                    .frame(width: deviceWidth*0.07, height: deviceHeight*0.06)
                Image(systemName: "arrowshape.right.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.brown)
            }
        }
    }
}

//struct NextButton_Previews: PreviewProvider {
//    static var previews: some View {
//        NextButton(isPressed: false)
//    }
//}
