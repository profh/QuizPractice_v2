//  QuestionParser.swift
//  QuizPractice

import Foundation
import SwiftyJSON

typealias JSONDictionary = [String: AnyObject]

class QuestionParser {
  
  func questionsFromFetchResponse(_ data: Data?) -> [Question]? {
    if let thisData = data {

      let swiftyjson = try! JSON(data: thisData as Data)
        
      var questions = [Question]()
      let total = swiftyjson["data"].count
      
      for i in 0..<total {
        
        if let prompt = swiftyjson["data"][i]["attributes"]["text"].string,
          let answer = swiftyjson["data"][i]["attributes"]["answer"].string,
          let verse = swiftyjson["data"][i]["attributes"]["bcv_reference"].string,
          let qtype = swiftyjson["data"][i]["attributes"]["question_type"].string
        {
          let question = Question(prompt: prompt, answer: answer, verse: verse, qtype: qtype)
          questions.append(question)
        }
      }
      
      return questions
    
    } else {
      print("Error: no data sent to parse")
      return nil
    }
    
  }
}
