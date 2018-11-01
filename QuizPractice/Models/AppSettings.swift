//  AppSettings.swift
//  QuizPractice


import Foundation

public class AppSettings {
  
  public static let shared = AppSettings()
  public var questionStrategyType = QuestionStrategyType.sequential
  
  private init() {
    
  }
  
  public func questionStrategy(for questionGroup: QuestionGroup) -> QuestionStrategy {
    return questionStrategyType.questionStrategy(for: questionGroup)
  }
}

// MARK: enum QuestionStrategyType
public enum QuestionStrategyType: Int {
  
  public static let allCases: [QuestionStrategyType] = [.alphabetical, .random, .sequential]
  case alphabetical
  case random
  case sequential
  
  public func questionStrategy(for questionGroup: QuestionGroup) -> QuestionStrategy {
    switch self {
    case .alphabetical:
      return AlphabeticalQuestionStrategy(questionGroup: questionGroup)
    case .random:
      return RandomQuestionStrategy(questionGroup: questionGroup)
    case .sequential:
      return SequentialQuestionStrategy(questionGroup: questionGroup)
    }
  }
  
  public func title() -> String {
    switch self {
    case .alphabetical:
      return "Alphabetical"
    case .random:
      return "Random"
    case .sequential:
      return "Sequential"
    }
  }
}
