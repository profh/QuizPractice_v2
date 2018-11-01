//  Loader.swift
//  QuizPractice

import Foundation
import UIKit
import CoreData
import os.log

class Loader {
  var questions = [Question]()
  var savedQuestions: [NSManagedObject] = []
  
  let client = GetQuestionsClient()
  let parser = QuestionParser()
  
  // MARK: - Get data from quizzing API
  func getDataFromAPI(_ completion: @escaping () -> Void) {
    client.fetchQuestions { [unowned self] data in
      self.client.fetchQuestions { [unowned self] data in
        if let theseQuestions = self.parser.questionsFromFetchResponse(data) {
          self.questions = theseQuestions
        }
        os_log("\nCompleted parsing")
        completion()
      }
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK: - Save to Core Data
  func saveQuestionsToDevice() {

    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // save the new data
    for question in self.questions {
      let entity = NSEntityDescription.entity(forEntityName: "SavedQuestion", in: managedContext)!

      let savedQuestion = NSManagedObject(entity: entity, insertInto: managedContext)

      savedQuestion.setValue(question.prompt, forKeyPath: "prompt")
      savedQuestion.setValue(question.answer, forKeyPath: "answer")
      savedQuestion.setValue(question.verse, forKeyPath: "verse")
      savedQuestion.setValue(question.qtype, forKeyPath: "qtype")

      do {
        try managedContext.save()
        savedQuestions.append(savedQuestion)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    os_log("\nLoader Saved Question Count = %@", String(savedQuestions.count))
  }
  
}
