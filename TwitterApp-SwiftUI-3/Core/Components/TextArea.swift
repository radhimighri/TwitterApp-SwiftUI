//
//  TextArea.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 07/02/2022.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeHolder: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeHolder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
        var body: some View {

            ZStack(alignment: .topLeading) {
                
                if text.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(Color(.placeholderText))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                
                TextEditor(text: $text)
                    .padding(4)
            }
            .font(.body)
        }
}



//struct TextArea_Previews: PreviewProvider {
//    static var previews: some View {
//        TextArea()
//    }
//}
