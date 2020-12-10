//
//  SelectableText.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/27.
//

import Foundation
import UIKit
import SwiftUI


// https://xiaozhuanlan.com/topic/2875103649 这个有边界问题

import SwiftUI
struct SelectableTextView: UIViewRepresentable {
    private var text: String
    private var scrollEnable: Bool
    private var textStyle: UIFont.TextStyle
    
    init(_ text: String, scrollEnable: Bool = false,textStyle: UIFont.TextStyle =  UIFont.TextStyle.body) {
        self.text = text.replacingOccurrences(of: "\\n", with: "\n")
        self.scrollEnable = scrollEnable
        self.textStyle = textStyle
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isEditable = false
        textView.textAlignment = .left
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = scrollEnable
        textView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        
        return textView
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    
}

struct TestTextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle  // 可以通过绑定调节字体大小
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        
        textView.delegate = context.coordinator
        
        return textView
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        init(_ text: Binding<String>) {
            self.text = text
        }
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
}
    
}
