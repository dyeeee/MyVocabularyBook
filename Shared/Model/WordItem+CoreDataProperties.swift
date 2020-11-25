//
//  WordItem+CoreDataProperties.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/25.
//
//

import Foundation
import CoreData


extension WordItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordItem> {
        return NSFetchRequest<WordItem>(entityName: "WordItem")
    }

    @NSManaged public var wordContent: String?
    @NSManaged public var phonetic: String?
    @NSManaged public var translation: String?
    @NSManaged public var collinsLevel: Int16
    @NSManaged public var oxfordLevel: Int16
    @NSManaged public var bncLevel: Int16
    @NSManaged public var frqLevel: Int16
    @NSManaged public var tag: String?
    @NSManaged public var exchanges: String?
    @NSManaged public var exampleSentences: String?
    @NSManaged public var starLevel: Int16
    @NSManaged public var isHistory: Int16
    @NSManaged public var state: String?
    @NSManaged public var attrTest1: String?
    @NSManaged public var attrTest2: String?
    @NSManaged public var attrTest3: String?

}

extension WordItem : Identifiable {

}
