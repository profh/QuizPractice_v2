//  SavedQuestion+CoreDataProperties.swift
//  QuizPractice


import Foundation
import CoreData


extension SavedQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedQuestion> {
        return NSFetchRequest<SavedQuestion>(entityName: "SavedQuestion")
    }

    @NSManaged public var answer: String?
    @NSManaged public var prompt: String?
    @NSManaged public var qtype: String?
    @NSManaged public var verse: String?

}
