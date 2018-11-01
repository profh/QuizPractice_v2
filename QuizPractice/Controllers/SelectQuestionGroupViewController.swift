//  SelectQuestionGroupViewController.swift
//  QuizPractice


import UIKit
import os.log

class SelectQuestionGroupViewController: UIViewController {

  // MARK: - Properties
  private var loader = Loader()
  
  private let appSettings = AppSettings.shared
  public var questionGroups = QuestionGroup.allGroups()
  private var selectedQuestionGroup: QuestionGroup!
  
  // MARK: - Outlets
  @IBOutlet internal var tableView: UITableView! {
    didSet {
      tableView.tableFooterView = UIView()
    }
  }
  
  // MARK: - Actions
  @IBAction func loadTapped(_ sender: Any) {
    os_log("\nLoad tapped")
    
    // go get the new questions from API
//    loader.getDataFromAPI { }
//    CoreDataManager.sharedManager.clearExistingData()
//    CoreDataManager.sharedManager.saveQuestionsToDevice()
//    self.questionGroups = QuestionGroup.allGroups()
    
    loader.getDataFromAPI { [unowned self] in
      DispatchQueue.main.async {

        // removing any existing questions in core data
        CoreDataManager.sharedManager.clearExistingData()

        // save the questions to core data
        self.loader.saveQuestionsToDevice()
        //CoreDataManager.sharedManager.saveQuestionsToDevice()

        // reset the group lists
        self.questionGroups = QuestionGroup.allGroups()
      }
    }
  }
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
}


// MARK: - UITableViewDataSource
extension SelectQuestionGroupViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return questionGroups.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
    let questionGroup = questionGroups[indexPath.row]
    cell.titleLabel.text = questionGroup.title
    
    questionGroup.score.runningPercentage.addObserver(cell, options: [.initial, .new]) {
      [weak cell] (percentage, _) in
      DispatchQueue.main.async {
        cell?.percentageLabel.text = String(format: "%.0f %%", round(100 * percentage))
      }
    }
    return cell
  }
}


// MARK: - UITableViewDelegate
extension SelectQuestionGroupViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    
    selectedQuestionGroup = questionGroups[indexPath.row]
    return indexPath
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let viewController = segue.destination
      as? QuestionViewController else { return }
    viewController.questionStrategy = appSettings.questionStrategy(for: selectedQuestionGroup)
    viewController.delegate = self
  }
}

// MARK: - QuestionViewControllerDelegate
extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
  func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int) {
    navigationController?.popToViewController(self, animated: true)
  }
  
  func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionGroup) {
    navigationController?.popToViewController(self, animated: true)
  }
}

