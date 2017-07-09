//
//  String.swift
//  TLSafone
//
//  Created by Nguyen Van Hoa on 3/7/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import Foundation
import UIKit
// MARK: Validation
public enum Regex {
    case alphabetCharatersOnly(from: Int, to: Int)
    case numberOnly
    case email1
    case email2
    case password(from: Int, to: Int)
    case url
    case postalCode
    case name(from: Int, to: Int)
    case numberphone(form: Int, to: Int)
}

public extension String {

    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }

    /**
     It's like substringFromIndex(index: String.Index), but it requires an Int as index
     - parameter from: From index
     - returns: Returns the substring from index
     */
    func subString(from: Int) -> String {
        return self.substring(from: characters.index(startIndex, offsetBy: from))
    }

    /**
     It's like substringToIndex(index: String.Index), but it requires an Int as index
     - parameter to: To index
     - returns: Returns the substring to index
     */
    func subString(toIndex: Int) -> String {
        return self.substring(to: characters.index(startIndex, offsetBy: toIndex))
    }

    /**
     Creates a substring from the given character
     - parameter character: The character
     - returns: Returns the substring from character
     */
    public func substring(fromCharacter character: Character) -> String? {
        if let index: Int = indexOfCharacter(character) {
            return subString(from: index)
        }
        return nil
    }

    /**
     Creates a substring to the given character
     - parameter character: The character
     - returns: Returns the substring to character
     */
    public func substring(toCharacter character: Character) -> String? {
        if let index: Int = indexOfCharacter(character) {
            return subString(toIndex: index)
        }
        return nil
    }

    /**
     Creates a substring with a given range
     - parameter range: The range
     - returns: Returns the string between the range
     */
    public func substringWithRange(_ range: Range<Int>) -> String {
        let start = characters.index(startIndex, offsetBy: range.lowerBound)
        let end = characters.index(startIndex, offsetBy: range.upperBound)
        return self.substring(with: start..<end)
    }

    // Converts self to a NSString
    public var NSS: NSString {
        return (self as NSString)
    }

    /**
     Remove double or more duplicated spaces
     - returns: String without additional spaces
     */
    public func removeExtraSpaces() -> String {
        return self.NSS.removeExtraSpaces() as String
    }


    /**
     Returns the index of the given character
     - parameter char: The character to search
     - returns: Returns the index of the given character, -1 if not found
     */
    public func indexOfCharacter(_ character: Character) -> Int {
        if let index = characters.index(of: character) {
            return characters.distance(from: startIndex, to: index)
        }
        return -1
    }
    /**
     Check if self has the given substring in case-sensitive
     - parameter string:        The substring to be searched
     - parameter caseSensitive: If the search has to be case-sensitive or not
     - returns: Returns true if founded, false if not
     */
    public func hasString(_ string: String, caseSensitive: Bool = true) -> Bool {
        if caseSensitive {
            return self.range(of: string) != nil
        } else {
            return self.lowercased().range(of: string.lowercased()) != nil
        }
    }

    /**
     Conver self to a capitalized string.
     Example: "This is a Test" will return "This is a test" and "this is a test" will return "This is a test"
     - returns: Returns the capitalized sentence string
     */
    public func sentenceCapitalizedString() -> String {
        if self.length == 0 {
            return ""
        }
        let uppercase: String = self.subString(toIndex: 1).uppercased()
        let lowercase: String = self.subString(from: 1).lowercased()
        return uppercase + lowercase
    }

    /**
     Used to calculate text height for max width and font

     - parameter width: Max width to fit text
     - parameter font:  Font used in text

     - returns: Returns the calculated height of string within width using given font
     */
    public func heightForWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        var size = CGSize.zero
        if self.length > 0 {
            let frame: CGRect = self.boundingRect(with: CGSize(width: width,
                height: 999999),
                options: .usesLineFragmentOrigin,
                attributes: [NSFontAttributeName: font],
                context: nil)
            size = CGSize(width: frame.size.width, height: frame.size.height + 1)
        }
        return size.height
    }

    func widthOfStringInLabel(sizeFont: Float, font: UIFont) -> Float{
        let label: UILabel = UILabel()
        label.text = self
        label.font = font
        return Float(label.intrinsicContentSize.width)
    }
    
    var length: Int {
        return self.characters.count
    }

    func validateWithRegex(_ regex: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    func removeHTMLTags(_ withString: String) -> String {
        let str = self.replacingOccurrences(of: "<[^>]+>", with: withString, options: .regularExpression, range: nil)
        return str
    }
    
    func validate(_ regex: Regex) -> Bool {
        var regexString = ""
        switch regex {
        case .alphabetCharatersOnly(let from, let to):
            regexString = "\\S[A-Za-z'. \\x{00C0}-\\x{00FF}\\x{1EA0}-\\x{1EFF}]{\(from),\(to)}"
        case .numberOnly:
            regexString = "^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"
        case .email1:
            regexString = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        case .email2:
            regexString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        case .password(let from, let to):
            regexString = "[a-zA-Z0-9]{\(from),\(to)}"
        case .url:
            regexString = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        case .postalCode:
            regexString = "(\\+[0-9]{1,4})"
        case .name(let from, let to):
            regexString = "[A-Za-z]{\(from),\(to)}"
        case .numberphone(let from, let to):
            regexString = "[0-9]{\(from),\(to)}"
        }
        return validateWithRegex(regexString)
    }

    func validateNameVI(to:Int,form:Int) ->Bool {
     // ten khong duc phep chua ky tu so va ky tu dac biet.
        let arrCharaterSpecial:[Character] = ["!","@","#","$","%","^","&","*","(",")","/","|","}","{","-","+","=","_",":",";","<",">",".",",","?","`","~"]
        let arrNumber:[Character] = ["0","1","2","3","4","5","6","7","8","9"]
        if self.characters.count < form || self.characters.count > to {
            return false
        }
        
        let arrContent = Array(self.characters)
        for i in 0..<arrContent.count {
            for j in 0..<arrCharaterSpecial.count {
                if arrContent[i] == arrCharaterSpecial[j] {
                    return false
                }
            }
            for n in 0..<arrNumber.count {
                if arrContent[i] == arrNumber[n] {
                    return false
                }
            }
        }
        return true
    }
    // MARK: - Convert String to Number
    var intValue: Int {
        return (self as NSString).integerValue
    }

    var doubleValue: Double {
        return (self as NSString).doubleValue
    }

    var floatValue: Float {
        return (self as NSString).floatValue
    }

    var boolValue: Bool {
        return (self as NSString).boolValue
    }

    //// MARK: - PATH
    var lastPathComponent: String {
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        get {
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        get {
            return (self as NSString).deletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        get {
            return (self as NSString).deletingPathExtension
        }
    }
    var pathComponents: [String] {
        get {
            return (self as NSString).pathComponents
        }
    }
    func stringByAppendingPathComponent(_ path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(_ ext: String) -> String? {
        let nsSt = self as NSString
        return nsSt.appendingPathExtension(ext)
    }
    
    func format(_ args: CVarArg?...) -> String? {
        var validatedArgs = [CVarArg]()
        for arg in args {
            guard let arg = arg else { return nil }
            validatedArgs.append(arg)
        }
        return NSString(format: self, arguments: getVaList(validatedArgs)) as String
    }
    
    mutating func replace(from: Int, to: Int, with content: String) {
//        replaceSubrange(index.index(startIndex, offsetBy: from)...index.index(startIndex, offsetBy: to), with: content)
        replaceSubrange(index(startIndex, offsetBy: from)...index(startIndex, offsetBy: to), with: content)
    }
    func stringFormatInt(input: Int) -> String {
        return String(format: "%02d", input)
    }
    
    func urlEncodeUTF8() -> String{
      return  self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    func md5() -> String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLength)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        
        for i in 0..<digestLength {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deinitialize()
        
        return String(format: hash as String)
    }
    
    func dateFormUp() -> String {
        //dateString:String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        
        let dateObj = dateFormatter.date(from: self)
        let date = Date()
        let calendar = Calendar.current
        // current date
        let currentYear = calendar.component(.year, from: date)
        let currentMonth = calendar.component(.month, from: date)
        let currentDay = calendar.component(.day, from: date)
        let currentHour = calendar.component(.hour, from: date)
        let currentMinute = calendar.component(.minute, from: date)
        let currentSecond = calendar.component(.second, from: date)
        // last date
        if dateObj == nil {
            return "00 00 00 00:00:00"
        }
        let Lastyear1 = calendar.component(.year, from: dateObj!)
        let LastMonth = calendar.component(.month, from: dateObj!)
        let LastDay = calendar.component(.day, from: dateObj!)
        let LastHour = calendar.component(.hour, from: dateObj!)
        let LastMinute = calendar.component(.minute, from: dateObj!)
        let LastSecond = calendar.component(.second, from: dateObj!)
        // progress
        
        if (currentYear - Lastyear1) == 0 {
            if (currentMonth - LastMonth) == 0 {
                if (currentDay - LastDay) == 0 {
                    if (currentHour - LastHour) == 0 {
                        if (currentMinute - LastMinute) == 0  {
                            if (currentSecond - LastSecond) == 0  {
                                return "vừa xong"
                            } else {
                                return "\(currentSecond - LastSecond) giây trước"
                            }
                        } else {
                            return "\(currentMinute - LastMinute) phút trước"
                        }
                    } else {
                        return "\(currentHour - LastHour) giờ trước"
                    }
                } else {
                    return "\(currentDay - LastDay) ngày trước"
                }
            } else {
                return "\(currentMonth - LastMonth) tháng trước"
            }
        } else {
            return "\(currentYear - Lastyear1) năm trước"
        }
    }
}
