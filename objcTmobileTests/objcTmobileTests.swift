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
  
  let storyboard = UIStoryboard(name: "Main", bundle: nil)
  var vc: TokenViewController!
  
  override func setUpWithError() throws {
    vc = storyboard.instantiateViewController(withIdentifier: "TokenViewController") as? TokenViewController
  }
  
  override func tearDownWithError() throws {
    vc = nil
    clearSharedData()
  }
  
  // helper functions
  func loadView(with data: Data?) {
    TapestryServices.shared()?._data = data
    // load the TokenViewController
    vc.loadViewIfNeeded()
    
    // When view appears the API call fires, in this case it just parse the Json and sets the textLabel
    vc.viewDidAppear(true)
  }
  
  func clearSharedData() {
    TapestryServices.shared()?._data = nil
  }
  
  // A simple test where the pulled JSON contains the expected data in the expected form
  func testGoodJson() {
    // A Json with the expected form, has some additional fields
    let testDic = ["dealerCode": "123",
                   "1": "A",
                   "2": "B",
                   "3": "C",
                   "pseudoUserId": "admin",
                   "tokenPasscode": "password"]
    let jsonData = try! JSONSerialization.data(withJSONObject: testDic, options: .fragmentsAllowed)
    
    loadView(with: jsonData)
    
    // Check that the textLabel has the expected string, no errors have occurred
    XCTAssertEqual(vc.textLabel.text, "Dealer Code: 123\nToken Code: admin\nPasscode: password")
  }

  // A test where the JSON has proper formatting, but is missing the "pseudoUserId" dictionary entry
  func testNoDealer() {
    let testDic = ["1": "A",
                   "2": "B",
                   "3": "C",
                   "pseudoUserId": "admin",
                   "tokenPasscode": "password"]
    let jsonData = try! JSONSerialization.data(withJSONObject: testDic, options: .fragmentsAllowed)
    
    loadView(with: jsonData)
    
    XCTAssertEqual(vc.textLabel.text, "Dealer Code: Not available\nToken Code: admin\nPasscode: password")
  }
  
  // A test where the data retrieved from the API call is nil
  func testNilData() {
    let errorMessage = "There was an error retrieving the Token"
    
    loadView(with: nil)
    
    XCTAssertEqual(vc.textLabel.text, errorMessage)
  }
  
  // A test where the data retrieved from the API call is not in the proper form
  func testbadData() {
    let badData = "".data(using: .utf8)!
    
    let errorMessage = "There was an error retrieving the Token"
    
    loadView(with: badData)
    
    XCTAssertEqual(vc.textLabel.text, errorMessage)
  }
  
  //A test where the JSON has proper formatting, but is missing the "pesudoUserID" dictionary entry
  func testNoUserID() {
    let testDic = ["1": "A",
                   "2": "B",
                   "dealerCode": "dealer",
                   "3": "C",
                   "tokenPasscode" : "hunter2"]
    let jsonData = try! JSONSerialization.data(withJSONObject: testDic, options: .fragmentsAllowed)
    
    loadView(with: jsonData)
    
    XCTAssertEqual(vc.textLabel.text, "Dealer Code: dealer\nToken Code: Not available\nPasscode: hunter2")
  }
  
    // A test where the JSON has proper formatting, but the passcode is the empty string
  func testPassCodeLength0Json() {
    let testDic = ["dealerCode": "123",
                   "1": "A",
                   "2": "B",
                   "3": "C",
                   "pseudoUserId": "admin",
                   "tokenPasscode": ""]
    let jsonData = try! JSONSerialization.data(withJSONObject: testDic, options: .fragmentsAllowed)
    
    loadView(with: jsonData)
    
    XCTAssertEqual(vc.textLabel.text, "Dealer Code: 123\nToken Code: admin\nPasscode: Not available")
  }
  
  // Testing that the activity indicator is animating after viewDidLoad, but stops once the the view enters viewDidAppear
  func testActivityIndicator() {
    let vc = storyboard.instantiateViewController(withIdentifier: "TokenViewController") as! TokenViewController
    vc.loadView()
    vc.viewDidLoad()
    XCTAssert(vc.activityIndicator.isAnimating)
    vc.viewDidAppear(true)
    XCTAssertFalse(vc.activityIndicator.isAnimating)
  }
  
  func testSettingsKioskModeAutorotate() {
    let shouldAutorotate = vc.shouldAutorotate
    
    XCTAssertEqual(shouldAutorotate, false)
    XCTAssertEqual(TapestryShell.shared().settings.kioskMode, true)
  }
  
  func testSettingsKioskModeInterfaceOrientations() {
    let supported = vc.supportedInterfaceOrientations
    let mode: UIInterfaceOrientationMask = TapestryShell.shared().settings.kioskMode ? .landscape : .all

    XCTAssertEqual(supported, .landscape)
    XCTAssertEqual(mode, supported)
  }
  
}
