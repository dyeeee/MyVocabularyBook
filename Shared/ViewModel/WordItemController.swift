//
//  WordItemController.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/27.
//

import Foundation
import CoreData
import SwiftUI

//目前ListViewModel一样，等跨数据需要跨多个页面的时候看怎么处理
class WordItemController: ObservableObject{
    @Published var itemList:[WordItem] = []
    
    init() {
        getAllItems()
    }
    
    func getAllItems() {
        let fetchRequest: NSFetchRequest<WordItem> = WordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "wordContent", ascending: true)
        
        fetchRequest.fetchLimit = 20
        //fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            //获取所有的Item
            itemList = try viewContext.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    func createTestItem() {
        let container = PersistenceController.shared.container
        let viewContext = container.viewContext
        
        for i in 0..<5{
            let wordItem = WordItem(context: viewContext)
            wordItem.wordContent = "Test-\(i)"
            wordItem.translation = "测试样例-\(i)"
        }
        
        saveToPersistentStore()
    }
    
    func preloadFromCSV() {
        let container = PersistenceController.shared.container
        let csvTool = CSVTools()
        
        var data = csvTool.readDataFromCSV(fileName: "IELTS_Words_small", fileType: "csv")
        data = csvTool.cleanRows(file: data ?? "d")
        let csvRows = csvTool.csv(data: data ?? "d")
        
        container.performBackgroundTask() { (context) in
            for i in 0 ..< (csvRows.count - 1) {
                //print(csvRows[i][0])
                let word = WordItem(context: context)
                word.wordContent = csvRows[i][1]
                word.phonetic = csvRows[i][2]
                word.attrTest1 = csvRows[i][3]
                word.translation = csvRows[i][4]
                word.tag = csvRows[i][5]
                word.exchanges = csvRows[i][6]
                word.exampleSentences = csvRows[i][11]
                //word.oxfordLevel =
            }
            do {
                context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                try context.save()
                print("后台加载完成")
                //在主队列异步加载一次
                DispatchQueue.main.async {
                    self.getAllItems()
                    print("重新获取数据完成")
                }
            }
            catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    
    
    func deleteAll()  {
        let viewContext = PersistenceController.shared.container.viewContext
        let allItems = NSFetchRequest<NSFetchRequestResult>(entityName: "WordItem")
        let delAllRequest = NSBatchDeleteRequest(fetchRequest: allItems)
         do {
            try viewContext.execute(delAllRequest)
            print("删除了全部")
            saveToPersistentStore()
         }
         catch { print(error) }
    }
    
    //更新， 传入一个Item实例对象, 修改这个实例
    func updateItem(ItemInstance: WordItem) {
        ItemInstance.wordContent = "test"
        saveToPersistentStore()
    }
    
    //保存
    func saveToPersistentStore() {
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            try viewContext.save()
            getAllItems()
            print("完成保存并重新给数据列表赋值")
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
}
