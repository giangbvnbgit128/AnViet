//
//  UILabel.swift
//  Koshien
//
//  Created by AsianTech on 6/6/16.
//  Copyright © 2016 Khoi Nguyen Nguyen. All rights reserved.
//

import UIKit

struct StringOption {
    var from: Int
    var to: Int
    var font: UIFont
}

extension UILabel {
    
    func setIndent(head: CGFloat = 0, tail: CGFloat = 0, firstLineHead: CGFloat = 0) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = head
        paragraphStyle.tailIndent = tail
        paragraphStyle.firstLineHeadIndent = firstLineHead
        paragraphStyle.alignment = textAlignment
        setParagraphStyle(paragraphStyle)
    }
    
    func setLineHeight(_ lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = textAlignment
        setParagraphStyle(paragraphStyle)
    }
    
    func setLineSpace(_ space: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        paragraphStyle.alignment = textAlignment
        setParagraphStyle(paragraphStyle)
    }
    
    func setParagraphStyle(_ paragraphStyle: NSMutableParagraphStyle) {
        guard let text = text else { return }
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(NSFontAttributeName,
                                value: font,
                                range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSParagraphStyleAttributeName,
                                value: paragraphStyle,
                                range: NSMakeRange(0, attrString.length))
        attributedText = attrString
    }
    
    func updateFontSizeAndNumberOfLineRealtime(_ options: [StringOption], numberOfFirstLine: Int) {
        guard let text = text, numberOfFirstLine > 0 else { return }
        if text.length <= numberOfFirstLine {
            numberOfLines = 1
        } else {
            numberOfLines = 2
            let attributedString = NSMutableAttributedString(string: text.subString(toIndex: numberOfFirstLine) + "\n" + text.subString(from: numberOfFirstLine))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2
            paragraphStyle.alignment = .center
            attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            self.attributedText = attributedString
        }
        updateFontSize(options)
    }
    
//    func updateFontSizeAndNumberOfLine(_ options: [StringOption], numberOfFirstLine: Int) {
//        guard let text = text, numberOfFirstLine > 0 else { return }
//       guard let status = KOSDataManager.shareInstance.currentStatus?.status else { return }
//        if status == HomeStatus.duringTournament {
//            if text.length > 6 {
//                self.font = CCFont(.HiraKakuPro, .W3, 10)
//            } else {
//                self.font = CCFont(.HiraKakuPro, .W3, 14)
//            }
//        } else {
//            if text.length <= numberOfFirstLine {
//                numberOfLines = 1
//            } else {
//                numberOfLines = 2
//                textAlignment = .center
//                self.text = text.subString(toIndex: numberOfFirstLine) + "\n" + text.subString(from: numberOfFirstLine)
//            }
//            updateFontSize(options)
//
//        }
//
//    }
    func updateFontSize(_ options: [StringOption]) {
        guard let lenght = text?.length else { return }
        for option in options {
            setupFontWithLenght(option, lenght: lenght)
        }
    }
    
    fileprivate func setupFontWithLenght(_ option: StringOption, lenght: Int) {
        if case option.from...option.to = lenght {
            font = option.font
        }
    }
}
