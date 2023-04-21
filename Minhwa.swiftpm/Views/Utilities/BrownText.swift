//
//  SwiftUIView.swift
//  
//
//  Created by 김영빈 on 2023/04/16.
//

import SwiftUI

struct BrownText: View {
    var text: String
    var bold: Bool = false
    
    var body: some View {
        if bold {
            Text(text)
                .foregroundColor(.brown)
                .fontWeight(.bold)
        } else {
            Text(text)
                .foregroundColor(.brown)
        }
    }
}

struct BrownText_Previews: PreviewProvider {
    static var previews: some View {
        BrownText(text: "Hello World", bold: false)
    }
}
