//
//  ListViewModel.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/25.
//

import Foundation
import CoreData
import SwiftUI

class ListViewModel: ObservableObject{
    @Published var itemList:[WordItem] = []
    
    func getAllItems() {
        let fetchRequest: NSFetchRequest<WordItem> = WordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "rating", ascending: false)
        
        fetchRequest.fetchLimit = 20
        //fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            //获取所有的Item
            itemList = try viewContext.fetch(fetchRequest)
            //print(itemList[0])
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
}
