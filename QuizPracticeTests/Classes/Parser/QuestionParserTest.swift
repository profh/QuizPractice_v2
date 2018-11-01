//  QuestionParserTest.swift
//  QuizPractice

import XCTest
@testable import QuizPractice

class QuestionParserTests: XCTestCase {
  let parser = QuestionParser()
  
  func test_questionsFromFetchResponse_with_nil_data() {
    let data: Data? = nil
    let results = parser.questionsFromFetchResponse(data)
    XCTAssertNil(results)
  }
  
  func test_questionsFromFetchResponse() {
    let data = loadJSONTestData("search-questions-response")
    let results = parser.questionsFromFetchResponse(data)
    XCTAssertEqual(12, results!.count)
    
    let first = results!.first!
    XCTAssertEqual("According to John chapter 6, Jesus went > where?", first.prompt)
    XCTAssertEqual("Up on a mountainside.", first.answer)
    XCTAssertEqual("John 6:3", first.verse)
    XCTAssertEqual("CR", first.qtype)
    
    let last = results!.last!
    XCTAssertEqual("Who ate manna > and died?", last.prompt)
    XCTAssertEqual("Your ancestors.", last.answer)
    XCTAssertEqual("John 6:58", last.verse)
    XCTAssertEqual("INT", last.qtype)
  }
  
  func loadJSONTestData(_ filename: String) -> Data? {
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
  }
}
