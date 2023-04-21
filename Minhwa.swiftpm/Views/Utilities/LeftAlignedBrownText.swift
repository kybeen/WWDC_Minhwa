//
//  SwiftUIView.swift
//  
//
//  Created by 김영빈 on 2023/04/16.
//

import SwiftUI

struct LeftAlignedBrownText: View {
    var text: String
    var bold: Bool = false
    var isTitle: Bool = false
    var fontSize: CGFloat = 50
    
    var body: some View {
        if isTitle {
            HStack {
                BrownText(text: text, bold: bold)
                    .font(.system(size: fontSize))
                Spacer()
            }
        } else {
            HStack {
                BrownText(text: text, bold: bold)
                    .font(.title2)
                Spacer()
            }
        }

    }
}

struct LeftAlignedBrownText_Previews: PreviewProvider {
    static var previews: some View {
        LeftAlignedBrownText(text: "Hello World", bold: true)
    }
}
