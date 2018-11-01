//  ViewController.swift
//  QuizPractice


import UIKit

// MARK: - QuestionViewControllerDelegate
protocol QuestionViewControllerDelegate: class {

  func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionGroup)
  
  // func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int)

}

class QuestionViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var promptLabel: UILabel!
  @IBOutlet weak var answerLabel: UILabel!
  @IBOutlet weak var answerButton: UIButton!
  @IBOutlet weak var numCorrectLabel: UILabel!
  @IBOutlet weak var numAttemptedLabel: UILabel!
  
  // MARK: - Instance variable
  public var questionGroup = QuestionGroup.intQuestions()  // we will let them choose in later iterations
  public var questionIndex = 0
  public var correctCount = 0
  public var questionCount = 0
  public var delegate: QuestionViewControllerDelegate?
  public var questionStrategy: QuestionStrategy! {
    didSet {
      navigationItem.title = questionStrategy.title()
    }
  }
  
  // MARK: - Actions
  @IBAction func correctTapped(_ sender: Any) {
    correctCount += 1
    questionStrategy.markQuestionCorrect()
    updateCounters()
    showNextQuestion()
  }
  
  @IBAction func wrongTapped(_ sender: Any) {
    questionStrategy.markQuestionIncorrect()
    updateCounters()
    showNextQuestion()
  }
  
  
  @IBAction func showAnswerLabel(_ sender: Any) {
    answerButton.isHidden = true
    answerLabel.isHidden = false
  }

  // MARK: - Question management
  private func showQuestion() {
    let question = questionStrategy.currentQuestion()
    answerLabel.text = question.answer
    promptLabel.text = question.prompt
    answerLabel.isHidden = true
    answerButton.isHidden = false
  }
  
  private func showNextQuestion() {
    if questionStrategy.advanceToNextQuestion() {
      showQuestion()
    }
    else {
      delegate?.questionViewController(self, didComplete: questionGroup)
      return
    }
  }
  
  private func updateCounters() {
    questionCount += 1
    numCorrectLabel.text = "\(correctCount)"
    numAttemptedLabel.text = "\(questionCount)"
  }
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    numCorrectLabel.text = "0"
    numAttemptedLabel.text = "0"
    showQuestion()
  }


  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }


}

