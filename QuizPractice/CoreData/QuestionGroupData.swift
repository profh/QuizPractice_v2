//  QuestionGroupData.swift
//  QuizPractice


import Foundation
import UIKit
import CoreData
import os.log

extension QuestionGroup {
  
  public static func allGroups() -> [QuestionGroup] {
    return [intQuestions(), maQuestions(), memoryVerses(), referenceQuestions()]
  }
  
  // MARK: - Interrogatives
  public static func intQuestions() -> QuestionGroup {
    var questions = [Question]()
    
    if let savedQuestions = CoreDataManager.sharedManager.fetchAllSavedQuestionsOfType(qtype: "INT") {
      for squestion in savedQuestions {
        let question = Question(prompt: squestion.prompt!, answer: squestion.answer!, verse: squestion.verse!, qtype: "INT")
        questions.append(question)
      }
      return QuestionGroup(questions: questions, title: "Interrogative Questions (INT)")
      
    } else {
      
      let questions = [Question(prompt: "NULL", answer: "NULL", verse: "NULL", qtype: "NULL")]
      return QuestionGroup(questions: questions, title: "Interrogative Questions (Load first)")
    }
  }

  // MARK: - Multiple answers
  public static func maQuestions() -> QuestionGroup {
    var questions = [Question]()
    
    if let savedQuestions = CoreDataManager.sharedManager.fetchAllSavedQuestionsOfType(qtype: "MA") {
      for squestion in savedQuestions {
        let question = Question(prompt: squestion.prompt!, answer: squestion.answer!, verse: squestion.verse!, qtype: "MA")
        questions.append(question)
      }
      return QuestionGroup(questions: questions, title: "Mutliple Answer Questions (MA)")
      
    } else {
      
      let questions = [Question(prompt: "NULL", answer: "NULL", verse: "NULL", qtype: "NULL")]
      return QuestionGroup(questions: questions, title: "Mutliple Answer Questions (Load first)")
    }
  }

  // MARK: - Memory verses
  public static func memoryVerses() -> QuestionGroup {
    var questions = [Question]()
    
    if let savedQuestions = CoreDataManager.sharedManager.fetchAllSavedQuestionsOfType(qtype: "FTV") {
      for squestion in savedQuestions {
        let question = Question(prompt: squestion.prompt!, answer: squestion.answer!, verse: squestion.verse!, qtype: "FTV")
        questions.append(question)
      }
      return QuestionGroup(questions: questions, title: "Finish the Verse Questions (FTV)")
      
    } else {
      
      let questions = [Question(prompt: "NULL", answer: "NULL", verse: "NULL", qtype: "NULL")]
      return QuestionGroup(questions: questions, title: "Finish the Verse Questions (Load first)")
    }
  }

  // MARK: - Reference questions
  public static func referenceQuestions() -> QuestionGroup {
    var questions = [Question]()
    
    if let savedQuestions = CoreDataManager.sharedManager.fetchAllSavedQuestionsOfType(qtype: "CR") {
      for squestion in savedQuestions {
        let question = Question(prompt: squestion.prompt!, answer: squestion.answer!, verse: squestion.verse!, qtype: "CR")
        questions.append(question)
      }
      return QuestionGroup(questions: questions, title: "Reference Questions (CR)")
      
    } else {
      
      let questions = [Question(prompt: "NULL", answer: "NULL", verse: "NULL", qtype: "NULL")]
      return QuestionGroup(questions: questions, title: "Reference Questions (CR)")
    }
  }
  
}
