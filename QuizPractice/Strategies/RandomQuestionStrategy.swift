//  RandomQuestionStrategy.swift
//  QuizPractice


import Foundation

// MARK: extensions for shuffling
extension MutableCollection {
  // Shuffles the contents of this collection. (stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift)
  // These functions are supposed to be added to later versions of Swift, but for now...
  
  mutating func shuffle() {
    let c = count
    guard c > 1 else { return }
    
    for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
      // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
      let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
      let i = index(firstUnshuffled, offsetBy: d)
      swapAt(firstUnshuffled, i)
    }
  }
}

extension Sequence {
  /// Returns an array with the contents of this sequence, shuffled.
  func shuffled() -> [Element] {
    var result = Array(self)
    result.shuffle()
    return result
  }
}

// MARK: RandomQuestionStrategy
public class RandomQuestionStrategy: BaseQuestionStrategy {
  
  // All we have to do here is modify our init so that we are drawing 20 questions of a given grouping at random
  
  // MARK: object lifecycle
  override public init(questionGroup: QuestionGroup) {
    super.init(questionGroup: questionGroup)
    var shuffledQuestions = self.questionGroup.questions.shuffled()
    self.questions = Array(shuffledQuestions[0..<20])
  }
  
}


