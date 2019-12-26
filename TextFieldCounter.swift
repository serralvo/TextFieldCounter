//
//  TextFieldCounter.swift
//  TextFieldCounter
//
//  Created by Fabricio Serralvo on 12/7/16.
//  Copyright © 2016 Fabricio Serralvo. All rights reserved.
//

import Foundation
import UIKit

open class TextFieldCounter: UITextField, UITextFieldDelegate {

    lazy internal var counterLabel: UILabel = UILabel()
    
    weak var counterDelegate: TextFieldCounterDelegate?
    
    // MARK: -
    private weak var _delegate: UITextFieldDelegate?
    open override var delegate: UITextFieldDelegate? {
        set {
            self._delegate = newValue
        }
        get {
            return self._delegate
        }
    }
    
    // MARK: - IBInspectable: Limits and behaviors
    
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
    
    // MARK: - Enumerations and Constants
    
    enum AnimationType {
        case basic
        case didReachLimit
        case unknown
    }
    
    static let defaultLength = 30
    
    // MARK: - Init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = self
        counterLabel = setupCounterLabel()
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        rightView = counterLabel
        rightViewMode = .whileEditing
    }
    
    // MARK: - Public Methods
    
    /**
     Initializes a new beautiful *TextFieldCounter*.
     
     - parameter frame: The frame of view.
     - parameter animate: Default is `true`.
     - parameter ascending: Default is `true`.
     - parameter limit: By default, if the number is not greater than 0, the limit will be `30`.
     - parameter counterColor: Default color is `UIColor.lightGray`.
     - parameter limitColor: Default color is `UIColor.red`.
    */
    
    public init(frame: CGRect, limit: Int, animate: Bool = true, ascending: Bool = true, counterColor: UIColor = .lightGray, limitColor: UIColor = .red) {
        
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
        
        let fontFrame : CGRect = CGRect(x: 0, y: 0, width: counterLabelWidth(), height: Int(frame.height))
        let label : UILabel = UILabel(frame: fontFrame)
        
        if let currentFont : UIFont = font {
            label.font = currentFont
            label.textColor = counterColor
            label.textAlignment = label.userInterfaceLayoutDirection == .rightToLeft ? .right : .left
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 1
        }
        
        return label
    }
    
    private func localizedString(of number: Int) -> String {
        return String.localizedStringWithFormat("%i", number)
    }
    
    private func counterLabelWidth() -> Int {
        let biggestText = localizedString(of: maxLength)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.lineBreakMode = .byWordWrapping
        
        var size : CGSize = CGSize()
        
        if let currentFont = font {
            size = biggestText.size(withAttributes: [NSAttributedString.Key.font: currentFont,
                                                     NSAttributedString.Key.paragraphStyle: paragraph])
        }
        
        return Int(size.width) + 15
    }
    
    private func updateCounterLabel(count: Int) {
        if count <= maxLength {
            if (ascending) {
                counterLabel.text = localizedString(of: count)
            } else {
                counterLabel.text = localizedString(of: maxLength - count)
            }
        }
        
        prepareToAnimateCounterLabel(count: count)
    }
    
    private func textFieldCharactersCount(textField: UITextField, string: String, changeCharactersIn range: NSRange) -> Int {
        
        var textFieldCharactersCount = 0
        
        if let textFieldText = textField.text {
            
            if !string.isEmpty {
                textFieldCharactersCount = textFieldText.count + string.count - range.length
            } else {
                textFieldCharactersCount = textFieldText.count - range.length
            }
        }
        
        return textFieldCharactersCount
    }
    
    private func checkIfNeedsCallDidReachMaxLengthDelegate(count: Int) {
        if (count >= maxLength) {
            counterDelegate?.didReachMaxLength(textField: self)
        }
    }

    // MARK: - Animations
    
    private func prepareToAnimateCounterLabel(count: Int) {
        
        var animationType : AnimationType = .unknown
        
        if (count >= maxLength) {
            animationType = .didReachLimit
        } else if (count <= maxLength) {
            animationType = .basic
        }
        
        animateTo(type: animationType)
    }
    
    private func animateTo(type: AnimationType) {
        
        switch type {
        case .basic:
            animateCounterLabelColor(color: counterColor)
        case .didReachLimit:
            animateCounterLabelColor(color: limitColor)
            fireHapticFeedback()
            if (animate) {
                counterLabel.shakeTo(transform: CGAffineTransform(translationX: 5, y: 0), duration: 0.3)
            }
        default:
            break
        }
    }
    
    private func animateCounterLabelColor(color: UIColor) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.counterLabel.textColor = color
        }, completion: nil)
    }
    
    // MARK: - Haptic Feedback
    
    private func fireHapticFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    // MARK: - UITextFieldDelegate
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var shouldChange = false
        let charactersCount = textFieldCharactersCount(textField: textField, string: string, changeCharactersIn: range)
        
        if string.isEmpty {
            shouldChange = true
        } else {
            shouldChange = charactersCount <= maxLength
        }
        
        updateCounterLabel(count: charactersCount)
        checkIfNeedsCallDidReachMaxLengthDelegate(count: charactersCount)
        
        return shouldChange
    }
    
    // MARK: - UITextFieldDelegate Forwarding

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing?(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing?(self)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldReturn?(self) ?? true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldClear?(self) ?? true
    }
    
}

// MARK: - TextFieldCounterDelegate

protocol TextFieldCounterDelegate : class {
    func didReachMaxLength(textField: TextFieldCounter)
}

// MARK: - Extensions

extension UIView {
    
    public func shakeTo(transform: CGAffineTransform, duration: TimeInterval) {
        
        self.transform = transform
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        return UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute)
    }
    
}
