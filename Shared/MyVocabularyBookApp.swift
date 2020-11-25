//
//  MyVocabularyBookApp.swift
//  Shared
//
//  Created by YES on 2020/11/24.
//

import SwiftUI

@main
struct MyVocabularyBookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
