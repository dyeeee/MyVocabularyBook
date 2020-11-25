//
//  WordListView.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/24.
//

import SwiftUI

//列出所有单词的页面

struct WordListView: View {
    @ObservedObject var viewModel: ListViewModel
    
    var body: some View {
        VStack{
            List{
                ForEach(self.viewModel.itemList){
                    item in
                    VStack{
                       Text("hi")
                    }
                }
                }
            }.navigationTitle("Word List")
            .navigationBarItems(trailing: Button(action: {
                self.viewModel.getAllItems()
            }, label: {
                Text("Refresh")
            }))
        }
    }

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        WordListView(viewModel: ListViewModel())
    }
}
