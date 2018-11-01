//  GetQuestionsClient.swift
//  QuizPractice

import Foundation
import Alamofire

class GetQuestionsClient {
  func fetchQuestions(_ completion: @escaping (Data?) -> Void) {
    
    let urlString = "https://profh.net/questions"
    
    Alamofire.request(urlString).response { response in
      if let error = response.error {
        print("Error fetching questions: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
}
