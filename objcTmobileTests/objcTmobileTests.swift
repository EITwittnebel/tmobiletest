//
//  objcTmobileTests.swift
//  objcTmobileTests
//
//  Created by Field Employee on 5/27/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import XCTest
@testable import objcTmobile

class objcTmobileTests: XCTestCase {
  
  // A simple test where the pulled JSON contains the expected data in the expected form
  @objc func testGoodJson() {
    // A Json with the expected form, has some additional fields
    let testDic = ["dealerCode": "123", "1": "A", "2": "B", "3": "C", "pseudoUserId" : "admin", "tokenPasscode" : "password"]
    let jsonData = try! JSONSerialization.data(withJSONObject: testDic, options: .fragmentsAllowed)
    
    // sets data that would be pulled from an API to the mock data above
    TapestryServices.shared()?._data = jsonData
    
    // load the TokenViewController
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc2 = storyboard.instantiateViewController(withIdentifier: "TokenViewController") as! TokenViewController
    vc2.loadView()
    vc2.viewDidLoad()
    
    // When view appears the API call fires, in this case it just parse the Json and sets the textLabel
    vc2.viewDidAppear(true)
    
    // Check that the textLabel has the expected string, no errors have occurred
    XCTAssert(vc2.textLabel.text! == "Dealer Code: 123\nToken Code: admin\nPasscode: password")
  }

  // A test where the JSON has proper formatting, but is missing the "pseudoUserId" dictionary entry
  @objc func testNoDealer() {
    let testDic = ["1": "A", "2": "B", "3": "C", "pseudoUserId" : "admin", "tokenPasscode" : "password"]
    let jsonData = try! JSONSerialization.data(withJSONObject: testDic, options: .fragmentsAllowed)
    
    TapestryServices.shared()?._data = jsonData
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc2 = storyboard.instantiateViewController(withIdentifier: "TokenViewController") as! TokenViewController
    vc2.loadView()
    vc2.viewDidLoad()
    vc2.viewDidAppear(true)
    XCTAssert(vc2.textLabel.text! == "Dealer Code: Not available\nToken Code: admin\nPasscode: password")
  }
  
  // A test where the data retrieved from the API call is nil
  @objc func testNilData() {
    let errorMessage = "There was an error retrieving the Token"
    TapestryServices.shared()?._data = nil
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc2 = storyboard.instantiateViewController(withIdentifier: "TokenViewController") as! TokenViewController
    vc2.loadView()
    vc2.viewDidLoad()
    vc2.viewDidAppear(true)
    XCTAssert(vc2.textLabel.text! == errorMessage)
  }
  
  // A test where the data retrieved from the API call is not in the proper form
  @objc func testbadData() {
    let badData = "".data(using: .utf8)!
    
    let expectedErrorMessage = "There was an error retrieving the Token"
    TapestryServices.shared()?._data = badData
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc2 = storyboard.instantiateViewController(withIdentifier: "TokenViewController") as! TokenViewController
    vc2.loadView()
    vc2.viewDidLoad()
    vc2.viewDidAppear(true)
    XCTAssertEqual(vc2.textLabel.text!, expectedErrorMessage)
  }
  
  //A test where the JSON has proper formatting, but is missing the "pesudoUserID" dictionary entry
  @objc func testNoUserID() {
    let testDic = ["1": "A", "2": "B","dealerCode": "dealer", "3": "C", "tokenPasscode" : "hunter2"]
    let jsonData = try! JSONSerialization.data(withJSONObject: testDic, options: .fragmentsAllowed)
    
    TapestryServices.shared()?._data = jsonData
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc2 = storyboard.instantiateViewController(withIdentifier: "TokenViewController") as! TokenViewController
    vc2.loadView()
    vc2.viewDidLoad()
    vc2.viewDidAppear(true)
    XCTAssert(vc2.textLabel.text! == "Dealer Code: dealer\nToken Code: Not available\nPasscode: hunter2")
  }
  
    // A test where the JSON has proper formatting, but the passcode is the empty string
  @objc func testPassCodeLength0Json() {
    let testDic = ["dealerCode": "123", "1": "A", "2": "B", "3": "C", "pseudoUserId" : "admin", "tokenPasscode" : ""]
    let jsonData = try! JSONSerialization.data(withJSONObject: testDic, options: .fragmentsAllowed)
    
    TapestryServices.shared()?._data = jsonData
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc2 = storyboard.instantiateViewController(withIdentifier: "TokenViewController") as! TokenViewController
    vc2.loadView()
    vc2.viewDidLoad()
    vc2.viewDidAppear(true)
    XCTAssert(vc2.textLabel.text! == "Dealer Code: 123\nToken Code: admin\nPasscode: Not available")
  }
  
  // Testing that the activity indicator is animating after viewDidLoad, but stops once the the view enters viewDidAppear
  @objc func testActivityIndicator() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc2 = storyboard.instantiateViewController(withIdentifier: "TokenViewController") as! TokenViewController
    vc2.loadView()
    vc2.viewDidLoad()
    XCTAssert(vc2.activityIndicator.isAnimating)
    vc2.viewDidAppear(true)
    XCTAssert(!vc2.activityIndicator.isAnimating)
  }
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
