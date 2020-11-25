//
//  WordDetailView.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/24.
//

import SwiftUI

//一个单词的详情页面
//关键在于，如何让每个不同地方的点进来的时候都是更新好的页面
//之前用一个全局controller实现的，用viewmodel的话不同页面有不同的模型？
//每次onAppear的时候都刷新一次？详情页面的Viewmodel之前没写过类似的
//List页面用一个model，
struct WordDetailView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct WordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WordDetailView()
    }
}
