//
//  TabVIew.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/24.
//

import SwiftUI

struct HomeTabView: View {
    @State var selectedTab: TabSelection = .page1
    @ObservedObject var listViewModel = ListViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                Text("page1")
                Button(action: {self.selectedTab = .page2}, label: {
                    Text("Button")
                })
            }
            .tabItem {
                Image(systemName:"newspaper")
                Text("Search")
            }
            .tag(TabSelection.page1)
            
            
            Text("page2")
                .tabItem {
                    Image(systemName:"text.book.closed")
                    Text("Note")
                }
                .tag(TabSelection.page2)
            
            WordListView(viewModel: listViewModel)
                .tabItem {
                    Image(systemName:"books.vertical")
                    Text("List")
                }
                .tag(TabSelection.page3)
        }
    }
}


enum TabSelection {
    case page1
    case page2
    case page3
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
