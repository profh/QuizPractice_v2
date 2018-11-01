//  AlphabeticalQuestionStrategy.swift
//  QuizPractice


import Foundation

// MARK: RandomQuestionStrategy
public class AlphabeticalQuestionStrategy: BaseQuestionStrategy {
  
  // All we have to do here is modify our init so that we are ordering questions alphabetically
  
  // MARK: object lifecycle
  override public init(questionGroup: QuestionGroup) {
    super.init(questionGroup: questionGroup)
    let alphabeticalQuestions = self.questionGroup.questions.sorted(by: {$0.prompt < $1.prompt})
    self.questions = alphabeticalQuestions
  }
  
}
