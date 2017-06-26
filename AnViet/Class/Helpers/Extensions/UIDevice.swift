//
//  UIDevice.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import UIKit

/**
 Get the iOS version string
 - returns: Get the iOS version string
 */
public func IOS_VERSION() -> String {
    return UIDevice.current.systemVersion
}

/**
 Compare system versions
 - parameter v: Version, like "9.0"
 - returns: Returns a Bool
 */
public func SYSTEM_VERSION_EQUAL_TO(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedSame
}

/**
 Compare system versions
 - parameter v: Version, like "9.0"
 - returns: Returns a Bool
 */
public func SYSTEM_VERSION_GREATER_THAN(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedDescending
}

/**
 Compare system versions
 - parameter v: Version, like "9.0"
 - returns: Returns a Bool
 */
public func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedAscending
}

/**
 Compare system versions
 - parameter v: Version, like "9.0"
 - returns: Returns a Bool
 */
public func SYSTEM_VERSION_LESS_THAN(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedAscending
}

/**
 Compare system versions
 - parameter v: Version, like "9.0"
 - returns: Returns a Bool
 */
public func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedDescending
}

/**
 Returns if the iOS version is greater or equal to choosed one
 - returns: Returns if the iOS version is greater or equal to choosed one
 */
public func IS_IOS_5_OR_LATER() -> Bool {
    return UIDevice.current.systemVersion.floatValue >= 5.0
}

/**
 Returns if the iOS version is greater or equal to choosed one
 - returns: Returns if the iOS version is greater or equal to choosed one
 */
public func IS_IOS_6_OR_LATER() -> Bool {
    return UIDevice.current.systemVersion.floatValue >= 6.0
}

/**
 Returns if the iOS version is greater or equal to choosed one
 - returns: Returns if the iOS version is greater or equal to choosed one
 */
public func IS_IOS_7_OR_LATER() -> Bool {
    return UIDevice.current.systemVersion.floatValue >= 7.0
}

/**
 Returns if the iOS version is greater or equal to choosed one
 - returns: Returns if the iOS version is greater or equal to choosed one
 */
public func IS_IOS_8_OR_LATER() -> Bool {
    return UIDevice.current.systemVersion.floatValue >= 8.0
}

/**
 Returns if the iOS version is greater or equal to choosed one
 - returns: Returns if the iOS version is greater or equal to choosed one
 */
public func IS_IOS_9_OR_LATER() -> Bool {
    return UIDevice.current.systemVersion.floatValue >= 9.0
}

public extension UIDevice {
    /**
     Returns the device platform string
     Example: "iPhone7,2"

     - returns: Returns the device platform string
     */
    public static func devicePlatform() -> String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, &name, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, &name, 0)

        let hardware: String = String(cString: hw_machine)
        return hardware
    }


    /**
     Returns the user-friendly device platform string
     Example: "iPad Air (Cellular)"

     - returns: Returns the user-friendly device platform string
     */
    public static func devicePlatformString() -> String {
        let platform: String = self.devicePlatform()
        let platformSource: [String: String] = [
            "iPhone1,1": "iPhone 2G",
            "iPhone1,2": "iPhone 3G",
            "iPhone2,1": "iPhone 3GS",
            "iPhone3,1": "iPhone 4 (GSM)",
            "iPhone3,2": "iPhone 4 (Rev. A)",
            "iPhone3,3": "iPhone 4 (CDMA)",
            "iPhone4,1": "iPhone 4S",
            "iPhone5,1": "iPhone 5 (GSM)",
            "iPhone5,2": "iPhone 5 (CDMA)",
            "iPhone5,3": "iPhone 5c (GSM)",
            "iPhone5,4": "iPhone 5c (Global)",
            "iPhone6,1": "iPhone 5s (GSM)",
            "iPhone6,2": "iPhone 5s (Global)",
            "iPhone7,1": "iPhone 6 Plus",
            "iPhone7,2": "iPhone 6",
            "iPhone8,1": "iPhone 6s",
            "iPhone8,2": "iPhone 6s Plus",
            "iPhone8,4": "iPhone SE",
            "iPhone9,1": "iPhone 7",
            "iPhone9,2": "iPhone 7 Plus",
            "iPhone9,3": "iPhone 7",
            "iPhone9,4": "iPhone 7 Plus",
            "iPod1,1": "iPod Touch 1G", // iPod
            "iPod2,1": "iPod Touch 2G",
            "iPod3,1": "iPod Touch 3G",
            "iPod4,1": "iPod Touch 4G",
            "iPod5,1": "iPod Touch 5G",
            "iPod7,1": "iPod Touch 6G",
            "iPad1,1": "iPad 1", // iPad
            "iPad2,1": "iPad 2 (WiFi)",
            "iPad2,2": "iPad 2 (GSM)",
            "iPad2,3": "iPad 2 (CDMA)",
            "iPad2,4": "iPad 2 (32nm)",
            "iPad3,1": "iPad 3 (WiFi)",
            "iPad3,2": "iPad 3 (CDMA)",
            "iPad3,3": "iPad 3 (GSM)",
            "iPad3,4": "iPad 4 (WiFi)",
            "iPad3,5": "iPad 4 (GSM)",
            "iPad3,6": "iPad 4 (CDMA)",
            "iPad4,1": "iPad Air (WiFi)",
            "iPad4,2": "iPad Air (Cellular)",
            "iPad4,3": "iPad Air (China)",
            "iPad5,3": "iPad Air 2 (WiFi)",
            "iPad5,4": "iPad Air 2 (Cellular)",
            "iPad2,5": "iPad mini (WiFi)",// iPad mini
            "iPad2,6": "iPad mini (GSM)",
            "iPad2,7": "iPad mini (CDMA)",
            "iPad4,4": "iPad mini 2 (WiFi)",
            "iPad4,5": "iPad mini 2 (Cellular)",
            "iPad4,6": "iPad mini 2 (China)",
            "iPad4,7": "iPad mini 3 (WiFi)",
            "iPad4,8": "iPad mini 3 (Cellular)",
            "iPad4,9": "iPad mini 3 (China)",
            "iPad6,7": "iPad Pro (WiFi)",// iPad Pro
            "iPad6,8": "iPad Pro (Cellular)",
            "AppleTV2,1": "Apple TV 2G",// Apple TV
            "AppleTV3,1": "Apple TV 3G",
            "AppleTV3,2": "Apple TV 3G",
            "AppleTV5,3": "Apple TV 4G",
            "Watch1,1": "Apple Watch 38mm",// Apple Watch
            "Watch1,2": "Apple Watch 42mm",
            "i386": "Simulator",// Simulator
            "x86_64": "Simulator" ]
        if let platformFromSource = platformSource[platform] {
            return platformFromSource
        } else {
            return platform
        }
    }



    /*
    Check if the current device is an iPad
    - returns: Returns true if it's an iPad, fasle if not
    */
    public static func isiPad() -> Bool {
        if devicePlatformString().subString(toIndex: 4) == "iPad" {
            return true
        }
        return false
    }

    /**
     Check if the current device is an iPhone
     - returns: Returns true if it's an iPhone, false if not
     */
    public static func isiPhone() -> Bool {
        if devicePlatformString().subString(toIndex: 6) == "iPhone" {
            return true
        }
        return false
    }
    
    /**
     Check if the current device is an iPhone
     - returns: Returns true if it's an iPhone, false if not
     */
    public static func isiPhone6Plus() -> Bool {
        if devicePlatformString().subString(toIndex: 6) == "iPhone 6 Plus" || devicePlatformString().subString(toIndex: 6) == "iPhone 6s Plus" {
            return true
        }
        return false
    }
    
    /**
     Check if the current device is an iPod
     - returns: Returns true if it's an iPod, false if not
     */
    public static func isiPod() -> Bool {
        if devicePlatformString().subString(toIndex: 4) == "iPod" {
            return true
        }
        return false
    }

    /**
     Check if the current device is an Apple TV
     - returns: Returns true if it's an Apple TV, false if not
     */
    public static func isAppleTV() -> Bool {
        if devicePlatform().subString(toIndex: 7) == "AppleTV" {
            return true
        }
        return false
    }

    /**
     Check if the current device is an Apple Watch
     - returns: Returns true if it's an Apple Watch, false if not
     */
    public static func isAppleWatch() -> Bool {
        if devicePlatform().subString(from: 5) == "Watch" {
            return true
        }
        return false
    }

    /**
     Check if the current device is a Simulator
     - returns: Returns true if it's a Simulator, false if not
     */
    public static func isSimulator() -> Bool {
        if devicePlatform() == "i386" || devicePlatform() == "x86_64" {
            return true
        }
        return false
    }

    /**
     Returns the iOS version without the subversion
     Example: 7

     - returns: Returns the iOS version
     */
    public static func iOSVersion() -> Int {
        return Int(UIDevice.current.systemVersion.substring(toCharacter: ".")!)!
    }

    /**
     Private, used to get the system info

     - parameter typeSpecifier: Type of the system info

     - returns: Return the sysyem info
     */
    fileprivate static func getSysInfo(_ typeSpecifier: Int32) -> Int {
        var name: [Int32] = [CTL_HW, typeSpecifier]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, &name, 0)
        var results: Int = 0
        sysctl(&name, 2, &results, &size, &name, 0)

        return results
    }

    /**
     Returns the current device CPU frequency

     - returns: Returns the current device CPU frequency
     */
    public static func cpuFrequency() -> Int {
        return self.getSysInfo(HW_CPU_FREQ)
    }

    /**
     Returns the current device BUS frequency

     - returns: Returns the current device BUS frequency
     */
    public static func busFrequency() -> Int {
        return self.getSysInfo(HW_TB_FREQ)
    }

    /**
     Returns the current device RAM size

     - returns: Returns the current device RAM size
     */
    public static func ramSize() -> Int {
        return self.getSysInfo(HW_MEMSIZE)
    }

    /**
     Returns the current device CPU number

     - returns: Returns the current device CPU number
     */
    public static func cpuNumber() -> Int {
        return self.getSysInfo(HW_NCPU)
    }

    /**
     Returns the current device total memory

     - returns: Returns the current device total memory
     */
    public static func totalMemory() -> Int {
        return self.getSysInfo(HW_PHYSMEM)
    }

    /**
     Returns the current device non-kernel memory

     - returns: Returns the current device non-kernel memory
     */
    public static func userMemory() -> Int {
        return self.getSysInfo(HW_USERMEM)
    }

    /**
     Returns the current device total disk space

     - returns: Returns the current device total disk space
     */
//    public static func totalDiskSpace() throws -> AnyObject {
////        let attributes: NSDictionary = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) as NSDictionary
////        return attributes.object(forKey: FileAttributeKey.systemSize)! as AnyObject
//        let attributes: NSDictionary = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) as NSDictionary
//        return attributes.object(forKey: FileAttributeKey.systemSize)! as AnyObject
//    }

    /**
     Returns the current device free disk space
     
     - returns: Returns the current device free disk space
     */
//    public static func freeDiskSpace() throws -> AnyObject {
//        let attributes: NSDictionary = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) as NSDictionary
//        return attributes.object(forKey: FileAttributeKey.systemFreeSize)! as AnyObject
//    }
}
