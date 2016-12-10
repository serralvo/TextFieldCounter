//
//  TextFieldCounter.swift
//  TextFieldCounter
//
//  Created by Fabricio Serralvo on 12/7/16.
//  Copyright © 2016 Fabricio Serralvo. All rights reserved.
//

import Foundation
import UIKit

class TextFieldCounter: UITextField, UITextFieldDelegate {

    var counterLabel: UILabel!
    
    // MARK: IBInspectable: Limits and behaviors
    @IBInspectable public var charactersLimit : Int = 30
    @IBInspectable public var animate : Bool = true
    
    // MARK: IBInspectable: Style
    @IBInspectable public var counterColor : UIColor! = UIColor.lightGray
    @IBInspectable public var limitColor: UIColor! = UIColor.red
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = self
        self.counterLabel = self.setupCounterLabel()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.rightView = self.counterLabel
        self.rightViewMode = .whileEditing
    }
    
    // MARK: Public Methods
    
    // MARK: Private Methods
    
    private func setupCounterLabel() -> UILabel! {
        
        let fontFrame : CGRect = CGRect(x: 0, y: 0, width: self.getCounterLabelWidth(), height: Int(self.frame.height))
        let label : UILabel = UILabel(frame: fontFrame)
        
        if let currentFont : UIFont = self.font {
            label.font = currentFont
            label.textColor = self.counterColor
            label.textAlignment = .left
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 1
        }
        
        return label
    }
    
    private func getCounterLabelWidth() -> Int {
        let biggestText : NSString = "\(self.charactersLimit)" as NSString
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.lineBreakMode = .byWordWrapping
        
        let size: CGSize = biggestText.size(attributes: [NSFontAttributeName: self.font!, NSParagraphStyleAttributeName : paragraph])
        
        return Int(size.width) + 15
    }
    
    private func updateCounterLabel(count: Int) {
        if count <= self.charactersLimit {
            self.counterLabel.text = "\(count)"
        }
    }
    
    private func getTextFieldCharactersCount(textField: UITextField, string: String) -> Int {
        
        var textFieldCharactersCount = 0
        
        if let textFieldText = textField.text {
            
            textFieldCharactersCount = textFieldText.characters.count + string.characters.count
            
            if string.isEmpty {
                textFieldCharactersCount = textFieldCharactersCount - 1
            }
        }
        
        return textFieldCharactersCount
    }

    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var shouldChange = false
        let textFieldCharactersCount = self.getTextFieldCharactersCount(textField: textField, string: string)
        
        if string.isEmpty {
            shouldChange = true
        } else {
            shouldChange = textFieldCharactersCount <= self.charactersLimit
        }
        
        self.updateCounterLabel(count: textFieldCharactersCount)
        
        return shouldChange
    }
    
}
