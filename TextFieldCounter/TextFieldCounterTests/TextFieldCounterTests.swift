//
//  TextFieldCounterTests.swift
//  TextFieldCounterTests
//
//  Created by Fabricio Serralvo on 7/1/17.
//  Copyright © 2017 Fabricio Serralvo. All rights reserved.
//

import XCTest
@testable import TextFieldCounter

class TextFieldCounterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTextGreaterThanTheLimit() {
        let textField = TextFieldCounter(frame: CGRect.zero, limit: 10, animate: true, ascending: true, counterColor: .black, limitColor: .red)
        let text = "hello hello hello"
        let range = NSMakeRange(0, 0)
        
        XCTAssertFalse(textField.textField(textField, shouldChangeCharactersIn: range, replacementString: text))
    }
    
    func testTextLessThanTheLimit() {
        let textField = TextFieldCounter(frame: CGRect.zero, limit: 10, animate: true, ascending: true, counterColor: .black, limitColor: .red)
        let text = "hello"
        let range = NSMakeRange(0, 0)
        
        XCTAssertTrue(textField.textField(textField, shouldChangeCharactersIn: range, replacementString: text))
    }
    
    func testDeletionOneCharacter() {
        let textField = TextFieldCounter(frame: CGRect.zero, limit: 10, animate: true, ascending: true, counterColor: .black, limitColor: .red)
        let initalText = "some text"
        textField.text = initalText
        
        let deletionText = ""
        let range = NSMakeRange(initalText.count - 2, 1)
        let _ = textField.textField(textField, shouldChangeCharactersIn: range, replacementString: deletionText)
        XCTAssertTrue(textField.counterLabel.text == "8")
    }
    
    func testMultipleDeletion() {
        let textField = TextFieldCounter(frame: CGRect.zero, limit: 20, animate: true, ascending: true, counterColor: .black, limitColor: .red)
        let initalText = "The quick brown fox"
        textField.text = initalText
        
        let deletionText = ""
        let range = NSMakeRange(initalText.count - 3, 3) // "fox" word
        let _ = textField.textField(textField, shouldChangeCharactersIn: range, replacementString: deletionText)
        XCTAssertTrue(textField.counterLabel.text == "16")
    }
}
