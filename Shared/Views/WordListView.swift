//
//  WordListView.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/24.
//

import SwiftUI


//列出所有单词的页面

struct WordListView: View {
    @ObservedObject var wordItemController: WordItemController
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("header"), footer: Text("footer")){
                    HStack {
                        TextField("Search", text: $searchText)
                        Button(action: {}, label: {
                            Image(systemName:"magnifyingglass")
                        })
                    }
                }
                
                Section(header: Text("header"), footer: Text("footer")) {
                    ForEach(self.wordItemController.itemList){
                        item in
                        NavigationLink(
                            destination: WordDetailView(wordItem:item,wordItemController:wordItemController)){
                        VStack(alignment:.leading){
                            Text(item.wordContent ?? "noContent")
                                .font(.title3)
                            Text(item.translation?.replacingOccurrences(of: "\\n", with: "; ") ?? "noTranslation")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                                
                        }}
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationTitle("Word List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { // <2>
                ToolbarItem(placement: .navigationBarLeading) { // <3>
                    Button {
                        self.wordItemController.deleteAll()
                    } label: {
                        Text("DeleteAll")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
                        Button(action: {
                            self.wordItemController.createTestItem()
                        }) {
                            Label("Create Test", systemImage: "plus.circle")
                        }
                        Button(action: {
                            self.wordItemController.preloadFromCSV()
                        }) {
                            Label("Preload", systemImage: "text.badge.plus")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            
        }
    }
}

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        WordListView(wordItemController: WordItemController())
    }
}


struct SearchBarView {
    //把这个搜索栏添加到navigationtitle的话就无法自动收缩
    //                HStack {
    //                     HStack {
    //                         Image(systemName: "magnifyingglass")
    //
    //                         TextField("search", text: $searchText, onEditingChanged: { isEditing in
    //                             self.showCancelButton = true
    //                         }, onCommit: {
    //                             print("onCommit")
    //                         }).foregroundColor(.primary)
    //
    //                         Button(action: {
    //                             self.searchText = ""
    //                         }) {
    //                             Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
    //                         }
    //                     }
    //                     .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
    //                     .foregroundColor(.secondary)
    //                     .background(Color(.secondarySystemBackground))
    //                     .cornerRadius(10.0)
    //
    //                     if showCancelButton  {
    //                         Button("Cancel") {
    //                                 UIApplication.shared.endEditing(true) // this must be placed before the other commands here
    //                                 self.searchText = ""
    //                                 self.showCancelButton = false
    //                         }
    //                         .foregroundColor(Color(.systemBlue))
    //                     }
    //                 }
    //                 .padding(.horizontal)
    //                 .navigationBarHidden(showCancelButton) //
    //                 .animation(.default)
}
