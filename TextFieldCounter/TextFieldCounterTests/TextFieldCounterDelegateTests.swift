//
//  TextFieldCounterDelegateTests.swift
//  TextFieldCounterTests
//
//  Created by Fabricio Serralvo on 26/12/19.
//  Copyright © 2019 Fabricio Serralvo. All rights reserved.
//

import XCTest
@testable import TextFieldCounter

class TextFieldCounterDelegateTests: XCTestCase {
    
    private let counterDelegateSpy = TextFieldCounterDelegateSpy()
    
    func test_textFieldWithCounterDelegate_whenHitMaxLimit_shouldCallDidReachMaxLength() {
        let text = "will reach max length"
        let sut = TextFieldCounter(frame: CGRect.zero, limit: text.count)
        sut.text = text
        sut.counterDelegate = counterDelegateSpy
        
        _ = sut.textField(sut, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "some string")
        
        XCTAssertTrue(counterDelegateSpy.didReachMaxLengthCalled)
    }
    
    func test_textFieldWithCounterDelegate_whenDoNotHitMaxLimit_shouldNotCallDidReachMaxLength() {
        let text = "will not reach max length"
        let sut = TextFieldCounter(frame: CGRect.zero, limit: 100)
        sut.text = text
        sut.counterDelegate = counterDelegateSpy
        
        _ = sut.textField(sut, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "some string")
        
        XCTAssertFalse(counterDelegateSpy.didReachMaxLengthCalled)
    }
    
}

private class TextFieldCounterDelegateSpy: TextFieldCounterDelegate {
    
    private (set) var didReachMaxLengthCalled: Bool = false
    
    func didReachMaxLength(textField: TextFieldCounter) {
        didReachMaxLengthCalled = true
    }
    
}
