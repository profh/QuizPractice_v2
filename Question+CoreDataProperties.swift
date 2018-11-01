//
//  Question+CoreDataProperties.swift
//  QuizPractice-CoreData
//
//  Created by Larry Heimann on 10/27/18.
//  Copyright © 2018 Larry Heimann. All rights reserved.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answer: String?
    @NSManaged public var prompt: String?
    @NSManaged public var qtype: String?
    @NSManaged public var verse: String?

}
