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
    
    @IBInspectable public dynamic var animate : Bool = true
    @IBInspectable public var maxLength : Int = 30 {
        didSet {
            if (!self.isValidMaxLength(max: self.maxLength)) {
                self.maxLength = TextFieldCounter.minLength
            }
        }
    }
    
    // MARK: IBInspectable: Style
    
    @IBInspectable public dynamic var counterColor : UIColor! = UIColor.lightGray
    @IBInspectable public dynamic var limitColor: UIColor! = UIColor.red
    
    // MARK: Enumerations and Constants
    
    enum AnimationType {
        case Default
        case DidReachLimit
        case Unknown
    }
    
    static let minLength = 30
    
    // MARK: Init
    
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
    
    init(frame: CGRect, limit: Int, shouldAnimate: Bool, colorOfCounterLabel: UIColor?, colorOfLimitLabel: UIColor?) {
        
        super.init(frame: frame)
        
        self.animate = shouldAnimate
        
        if !self.isValidMaxLength(max: limit) {
            self.maxLength = TextFieldCounter.minLength
        } else {
            self.maxLength = limit
        }
        
        if let counterTextColor = colorOfCounterLabel {
            self.counterColor = counterTextColor
        } else {
            self.counterColor = UIColor.lightGray
        }
        
        if let limitTextColor = colorOfLimitLabel {
            self.limitColor = limitTextColor
        } else {
            self.limitColor = UIColor.red
        }
        
        super.delegate = self
        self.counterLabel = self.setupCounterLabel()
    }
    
    // MARK: Private Methods
    
    private func isValidMaxLength(max: Int) -> Bool {
        return max > 0
    }
    
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
        let biggestText : NSString = "\(self.maxLength)" as NSString
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.lineBreakMode = .byWordWrapping
        
        let size: CGSize = biggestText.size(attributes: [NSFontAttributeName: self.font!, NSParagraphStyleAttributeName : paragraph])
        
        return Int(size.width) + 15
    }
    
    private func updateCounterLabel(count: Int) {
        if count <= self.maxLength {
            self.counterLabel.text = "\(count)"
        }
        
        self.prepareToAnimateCounterLabel(count: count)
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

    // MARK: Animations
    
    private func prepareToAnimateCounterLabel(count: Int) {
        
        var animationType : AnimationType = .Unknown
        
        if (count >= self.maxLength) {
            animationType = .DidReachLimit
        } else if (count <= self.maxLength) {
            animationType = .Default
        }
        
        self.animateTo(type: animationType)
    }
    
    private func animateTo(type: AnimationType) {
        
        switch type {
        case .Default:
            self.animateCounterLabelColor(color: self.counterColor)
            break
        case .DidReachLimit:
            self.animateCounterLabelColor(color: self.limitColor)
            
            if (self.animate) {
                self.counterLabel.shakeTo(transform: CGAffineTransform(translationX: 5, y: 0), duration: 0.3)
            }
            
            break
        default:
            print("Ops, nothing to animate")
            break
        }
    }
    
    private func animateCounterLabelColor(color: UIColor) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.counterLabel.textColor = color
        }, completion: nil)
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var shouldChange = false
        let textFieldCharactersCount = self.getTextFieldCharactersCount(textField: textField, string: string)
        
        if string.isEmpty {
            shouldChange = true
        } else {
            shouldChange = textFieldCharactersCount <= self.maxLength
        }
        
        self.updateCounterLabel(count: textFieldCharactersCount)
        
        return shouldChange
    }
    
}

extension UIView {
    
    public func shakeTo(transform: CGAffineTransform, duration: TimeInterval) {
        
        self.transform = transform
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
}
