//
//  NSUserDefaults.swift
//  Koshien
//
//  Created by HoaNV-iMac on 4/5/16.
//  Copyright © 2016 Khoi Nguyen Nguyen. All rights reserved.
//

import Foundation

public let UserDefaults = Foundation.UserDefaults.standard

open class UserDefaultKeys {
    fileprivate init() {}
}

open class Key<ValueType>: UserDefaultKeys {
    open let name: String
    public init(name: String) {
        self.name = name
    }
}

extension Foundation.UserDefaults {
    class Result {
        fileprivate let defaults: Foundation.UserDefaults
        fileprivate let key: String
        fileprivate init(defaults: Foundation.UserDefaults, key: String) {
            self.defaults = defaults
            self.key = key
        }
        // MARK: Getters
        var object: AnyObject? { return defaults.object(forKey: key) as AnyObject? }
        var string: String? { return defaults.string(forKey: key) }
        var array: [AnyObject]? { return defaults.array(forKey: key) as [AnyObject]? }
        var dictionary: [String : AnyObject]? { return defaults.dictionary(forKey: key) as [String : AnyObject]? }
        var data: Data? { return defaults.data(forKey: key) }
        var date: Date? { return object as? Date }
        var integer: Int { return defaults.integer(forKey: key) }
        var double: Double { return defaults.double(forKey: key) }
        var bool: Bool { return defaults.bool(forKey: key) }
        var float: Float { return defaults.float(forKey: key) }
    }
    
    @nonobjc subscript(key: String) -> Result {
        return Result(defaults: self, key: key)
    }
    
    @nonobjc subscript(key: String) -> Any? {
        get {
            let result: Result = self[key]
            return result
        }
        set {
            switch newValue {
            case let v as Int: set(v, forKey: key)
            case let v as Double: set(v, forKey: key)
            case let v as Bool: set(v, forKey: key)
            case let v as Float: set(v, forKey: key)
            case let v as URL: set(v, forKey: key)
            case let v as NSObject: set(v, forKey: key)
            case nil: removeObject(forKey: key)
            default: assertionFailure("Invalid value type")
            }
            UserDefaults.synchronize()
        }
    }
    
    public func setValue<T>(_ value: Any?, key: Key<T>) {
        self[key.name] = value
    }
    
    public func hasKey<T>(_ key: Key<T>) -> Bool {
        return object(forKey: key.name) != nil
    }
    
    public func removeValueForKey<T>(_ key: Key<T>) {
        removeObject(forKey: key.name)
    }
    
    subscript(key: Key<String>) -> String? {
        get {
            return string(forKey: key.name)
        }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<Bool>) -> Bool {
        get { return bool(forKey: key.name) }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<Int>) -> Int {
        get { return integer(forKey: key.name) }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<Double>) -> Double {
        get { return double(forKey: key.name) }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<Float>) -> Float {
        get { return float(forKey: key.name) }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<AnyObject>) -> AnyObject? {
        get { return object(forKey: key.name) as AnyObject? }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<[String]>) -> [String]? {
        get { return stringArray(forKey: key.name) }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<[AnyObject]>) -> [AnyObject]? {
        get { return array(forKey: key.name) as [AnyObject]? }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<[String: AnyObject]>) -> [String: AnyObject]? {
        get { return dictionary(forKey: key.name) as [String : AnyObject]? }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<Date>) -> Date? {
        get { return object(forKey: key.name) as? Date }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<URL>) -> URL? {
        get { return url(forKey: key.name) }
        set { setValue(newValue, key: key) }
    }
    subscript(key: Key<Data>) -> Data? {
        get { return data(forKey: key.name) }
        set { setValue(newValue, key: key) }
    }
}

