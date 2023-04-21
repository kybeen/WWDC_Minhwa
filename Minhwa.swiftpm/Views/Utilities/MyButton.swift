import SwiftUI

struct MyButton: View {
    var sfSymbol: String
    var symbolSize: CGFloat = 30
    var text: String
    var width: CGFloat = 110
    var height: CGFloat = 50
    var bold: Bool = false
    
    var action: () -> Void
    
    var body: some View {
        Button {
            // action
            action()
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: width, height: height)
                    .cornerRadius(10)
                    .foregroundColor(.brown)
                HStack {
                    Image(systemName: sfSymbol)
                        .resizable()
                        .frame(width: symbolSize, height: symbolSize)
                        .foregroundColor(.white)
                    if bold {
                        Text(text)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    } else {
                        Text(text)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        MyButton(sfSymbol: "photo.artframe", text: "Save", bold: true) {
            print("Save Painting")
        }
    }
}
