//  QuestionStrategy.swift
//  QuizPractice


import Foundation

public protocol QuestionStrategy: class {
  
  func currentQuestion() -> Question
  
  func advanceToNextQuestion() -> Bool

  func title() -> String
  
  func markQuestionCorrect()
  
  func markQuestionIncorrect()
  
}
