//
//  NoteBookView.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/12/10.
//

import SwiftUI

struct NoteBookView: View {
    
    @State var searchContent = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                HStack {
                    HStack {
                        TextField("Search", text: $searchContent)
                            .padding()
                        Button(action: {}, label: {
                            Image(systemName:"magnifyingglass")
                                .padding()
                        })
                    }.background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
                }
                .padding(.horizontal)
                .padding(.top)
                .background(Color("Background"))
                
                
                List{
                    Section(header: Text("header")){
                        HStack {
                            Text("test")
                        }
                    }
                    
                }.listStyle(SidebarListStyle())
                .padding(0)
                
            }.navigationBarTitle("生词本")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NoteBookView_Previews: PreviewProvider {
    static var previews: some View {
        NoteBookView()
    }
}
