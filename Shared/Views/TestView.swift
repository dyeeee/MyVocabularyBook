//
//  TestView.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/12/10.
//

import SwiftUI

struct TestView: View {
    @State private var message = "input here"
    @State private var textStyle = UIFont.TextStyle.body
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                SelectableTextView("ssssssssssssssssssssssssssss").frame(width: 100, height: 100, alignment: .center)
                
                TestTextView(text: $message, textStyle: $textStyle)
                    .padding(.horizontal)
            }
            Button(action: {
                self.textStyle = (self.textStyle == .body) ? .title1 : .body
            }) {
                Image(systemName: "textformat")
                    .imageScale(.large)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .clipShape(Circle())
            }
            .padding()
}
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
