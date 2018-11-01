//  CoreDataManager.swift
//  QuizPractice

import Foundation
import CoreData
import UIKit
import os.log

class CoreDataManager {
  
  // Setting up as a singleton
  static let sharedManager = CoreDataManager()
  private init() {}
  
  // Containers to hold questions
  var questions = [Question]()
  var savedQuestions: [NSManagedObject] = []
  
  //MARK: - Setting up stack
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "QuizPractice")
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  
  func saveContext () {
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  //MARK: - Save questions to Core Data
  func saveQuestionsToDevice() {
    
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
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
    os_log("\nCDM Saved Question Count = %@", String(savedQuestions.count))
  }
  
  
  //MARK: - Remove old data from Core Data
  func clearExistingData() {

    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedQuestion")
    
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
    
    batchDeleteRequest.resultType = .resultTypeCount
    
    do {

      let batchDeleteResult = try managedContext.execute(batchDeleteRequest) as! NSBatchDeleteResult

      managedContext.reset()
      
      os_log("\nCDM deleted records")

    } catch {
      let updateError = error as NSError
      print("\(updateError), \(updateError.userInfo)")
    }
  }
  
  func fetchAllSavedQuestionsOfType(qtype: String) -> [SavedQuestion]?{
    
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedQuestion")
    fetchRequest.predicate = NSPredicate(format: "qtype == %@", qtype)

    
    do {
      let savedQuestions = try managedContext.fetch(fetchRequest)
      return savedQuestions as? [SavedQuestion]
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
      return nil
    }
  }
  
}
