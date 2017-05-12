//
//  TextFieldCounter.swift
//  TextFieldCounter
//
//  Created by Fabricio Serralvo on 12/7/16.
//  Copyright © 2016 Fabricio Serralvo. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 10.0, *)
class TextFieldCounter: UITextField, UITextFieldDelegate {

    lazy private var counterLabel: UILabel = UILabel()
    
    weak var counterDelegate: TextFieldCounterDelegate?
    var feedbackGenerator: UINotificationFeedbackGenerator?
    
    // MARK: IBInspectable: Limits and behaviors
    
    @IBInspectable public dynamic var animate : Bool = true
    @IBInspectable public dynamic var ascending : Bool = true
    @IBInspectable public var maxLength : Int = TextFieldCounter.defaultLength {
        didSet {
            if (!isValidMaxLength(max: maxLength)) {
                maxLength = TextFieldCounter.defaultLength
            }
        }
    }
    @IBInspectable public dynamic var counterColor : UIColor = .lightGray
    @IBInspectable public dynamic var limitColor: UIColor = .red
    
    // MARK: Enumerations and Constants
    
    enum animationType {
        case basic
        case didReachLimit
        case unknown
    }
    
    static let defaultLength = 30
    
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = self
        counterLabel = setupCounterLabel()
        feedbackGenerator = UINotificationFeedbackGenerator()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        rightView = counterLabel
        rightViewMode = .whileEditing
    }
    
    // MARK: Public Methods
    
    /**
     Initializes a new beautiful *TextFieldCounter*.
     
     - parameter frame: The frame of view.
     - parameter animate: Default is `true`.
     - parameter ascending: Default is `true`.
     - parameter limit: By default, if the number is not greater than 0, the limit will be `30`.
     - parameter counterColor: Default color is `UIColor.lightGray`.
     - parameter limitColor: Default color is `UIColor.red`.
    */
    
    init(frame: CGRect, limit: Int, animate: Bool = true, ascending: Bool = true, counterColor: UIColor = .lightGray, limitColor: UIColor = .red) {
        
        super.init(frame: frame)
        
        if !isValidMaxLength(max: limit) {
            maxLength = TextFieldCounter.defaultLength
        } else {
            maxLength = limit
        }
        
        self.animate = animate
        self.ascending = ascending
        self.counterColor = counterColor
        self.limitColor = limitColor
        
        self.backgroundColor = .white
        self.layer.borderWidth = 0.35
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        super.delegate = self
        counterLabel = setupCounterLabel()
    }
    
    // MARK: Private Methods
    
    private func isValidMaxLength(max: Int) -> Bool {
        return max > 0
    }
    
    private func setupCounterLabel() -> UILabel {
        
        let fontFrame : CGRect = CGRect(x: 0, y: 0, width: getCounterLabelWidth(), height: Int(frame.height))
        let label : UILabel = UILabel(frame: fontFrame)
        
        if let currentFont : UIFont = font {
            label.font = currentFont
            label.textColor = counterColor
            label.textAlignment = .left
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 1
        }
        
        return label
    }
    
    private func getCounterLabelWidth() -> Int {
        let biggestText = "\(maxLength)"
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.lineBreakMode = .byWordWrapping
        
        var size : CGSize = CGSize()
        
        if let currentFont = font {
            size = biggestText.size(attributes: [NSFontAttributeName: currentFont, NSParagraphStyleAttributeName: paragraph])
        }
        
        return Int(size.width) + 15
    }
    
    private func updateCounterLabel(count: Int) {
        if count <= maxLength {
            if (ascending) {
                counterLabel.text = "\(count)"
            } else {
                counterLabel.text = "\(maxLength - count)"
            }
        }
        
        prepareToAnimateCounterLabel(count: count)
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
    
    private func checkIfNeedsCallDidReachMaxLengthDelegate(count: Int) {
        if (count >= maxLength) {
            counterDelegate?.didReachMaxLength(textField: self)
        }
    }

    // MARK: Animations
    
    private func prepareToAnimateCounterLabel(count: Int) {
        
        var animationType : animationType = .unknown
        
        if (count >= maxLength) {
            animationType = .didReachLimit
        } else if (count <= maxLength) {
            animationType = .basic
        }
        
        animateTo(type: animationType)
    }
    
    private func animateTo(type: animationType) {
        
        switch type {
        case .basic:
            animateCounterLabelColor(color: counterColor)
            break
        case .didReachLimit:
            animateCounterLabelColor(color: limitColor)
            addHapticFeedBack()
            
            if (animate) {
                counterLabel.shakeTo(transform: CGAffineTransform(translationX: 5, y: 0), duration: 0.3)
            }
            
            break
        default:
            break
        }
    }
    private func addHapticFeedBack() {
        feedbackGenerator?.notificationOccurred(.error)
    }
    
    private func animateCounterLabelColor(color: UIColor) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.counterLabel.textColor = color
        }, completion: nil)
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var shouldChange = false
        let textFieldCharactersCount = getTextFieldCharactersCount(textField: textField, string: string)
        
        if string.isEmpty {
            shouldChange = true
        } else {
            shouldChange = textFieldCharactersCount <= maxLength
        }
        
        updateCounterLabel(count: textFieldCharactersCount)
        checkIfNeedsCallDidReachMaxLengthDelegate(count: textFieldCharactersCount)
        
        return shouldChange
    }
    
}

// MARK: TextFieldCounterDelegate

protocol TextFieldCounterDelegate : class {
    func didReachMaxLength(textField: TextFieldCounter)
}

extension UIView {
    
    public func shakeTo(transform: CGAffineTransform, duration: TimeInterval) {
        
        self.transform = transform
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
}
