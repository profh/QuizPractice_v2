//  BaseQuestionStrategy.swift
//  QuizPractice


import Foundation

public class BaseQuestionStrategy: QuestionStrategy {
  
  // MARK: properties
  public let questionGroup: QuestionGroup
  public var questionIndex = 0
  public var questions: [Question]
  public var correctCount: Int {
    get { return questionGroup.score.correctCount }
    set { questionGroup.score.correctCount = newValue }
  }
  public var questionCount: Int {
    get { return questionGroup.score.questionCount }
    set { questionGroup.score.questionCount = newValue }
  }
  
  // MARK: init
  public init(questionGroup: QuestionGroup) {
    self.questionGroup = questionGroup
    self.questions = questionGroup.questions
  }
  
  // MARK: implementing protocol
  public func currentQuestion() -> Question {
    return questions[questionIndex]
  }
  
  public func advanceToNextQuestion() -> Bool {
    guard questionIndex + 1 < questions.count else {
      return false
    }
    questionIndex += 1
    return true
  }
  
  public func title() -> String {
    return questionGroup.title
  }
  
  public func markQuestionCorrect() {
    correctCount += 1
    questionCount += 1
  }
  
  public func markQuestionIncorrect() {
    questionCount += 1
  }
  
  
}
