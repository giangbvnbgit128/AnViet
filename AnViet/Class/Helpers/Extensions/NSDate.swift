//
//  NSDate.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import Foundation

extension Date {
    /// Time period (i.e. `AM` and `PM`)
    fileprivate enum Period: String {
        case AMPeriod
        case PMPeriod
    }
    /**
     TimeFormat is an enum for formatting timestamps.

     Given an hour, minute, and second, the time will be formatted in one of four formats.
     - `HourMinuteMilitary` (e.g. "19:41")
     - `HourMinutePeriod` (e.g. "07:41 PM")
     - `HourMinuteSecondMilitary` (e.g. "19:41:30")
     - `HourMinuteSecondPeriod` (e.g. "07:41:30 PM")
     */
    public enum TimeFormat {
        /// Military time with hours and minutes (e.g. "19:41")
        case hourMinuteMilitary
        /// Standard time with hours and minutes (e.g. "07:41 PM")
        case hourMinutePeriod
        /// Military time with hours, minutes, and seconds (e.g. "19:41:30")
        case hourMinuteSecondMilitary
        /// Standard time with hours, minutes, and seconds (e.g. "07:41:30 PM")
        case hourMinuteSecondPeriod
        /**
         Convert the hour, minute, and second to the specified format.

         - parameter hour: The hour.
         - parameter minute: The minute.
         - parameter second: The second.

         - returns: The formatted string
         */
        public func convert(hour: Int, minute: Int, second: Int) -> String {

            assert((0..<24).contains(hour), "The hour \(hour) is outside the valid range of 0-23")
            assert((0..<60).contains(minute), "The minute \(minute) is outside the valid range of 0-59")
            assert((0..<60).contains(second), "The second \(second) is outside the valid range of 0-59")

            switch self {
            case .hourMinuteMilitary:
                return String(format: "%02d:%02d", hour, minute)
            case .hourMinutePeriod:
                let (adjustedHour, period) = adjustHourForPeriod(hour)
                return String(format: "%02d:%02d %@", adjustedHour, minute, period.rawValue)
            case .hourMinuteSecondMilitary:
                return String(format: "%02d:%02d:%02d", hour, minute, second)
            case .hourMinuteSecondPeriod:
                let (adjustedHour, period) = adjustHourForPeriod(hour)
                return String(format: "%02d:%02d:%02d %@", adjustedHour, minute, second, period.rawValue)
            }
        }

        /**
         Adjust the hour to a 12-hour time and return the period.

         For example, and input of 13 returns (hour: 1, period: .PM).

         - parameter hour: The hour to adjust.

         - returns: The adjusted hour and period
         */
        fileprivate func adjustHourForPeriod(_ hour: Int) -> (hour: Int, period: Period) {
            let adjustedHour: Int
            let period: Period

            switch hour {
            case 0:
                adjustedHour = 12
                period = .AMPeriod
            case 12:
                adjustedHour = 12
                period = .PMPeriod
            case 13...23:
                adjustedHour = hour - 12
                period = .PMPeriod
            default:
                adjustedHour = hour
                period = .AMPeriod
            }

            return (hour: adjustedHour, period: period)
        }
    }

    /**
     Returns an NSDate object initialized with the provided month, day, and year

     - parameter month: The month
     - parameter day: The day
     - parameter year: The year

     - returns: An NSDate object initialized with the provided month, day, and year
     */
    public init?(month: Int, day: Int, year: Int) {
        let calendar = Calendar.current

        var components = DateComponents()
        components.month = month
        components.day = day
        components.year = year

        if let date = calendar.date(from: components) {
            self.init(timeInterval: 0, since: date)

        } else {
            self.init(timeIntervalSince1970: 0) // required by the compiler
            return nil
        }
    }

    /// The current year
    public static var currentYear: Int {
        let calendar = Calendar.autoupdatingCurrent
        let components = (calendar as NSCalendar).components(.year, from: Date())
        return components.year!
    }

    /// The current month
    public static var currentMonth: Int {
        let calendar = Calendar.autoupdatingCurrent
        let components = (calendar as NSCalendar).components(.month, from: Date())
        return components.month!
    }

    /// The current day
    public static var currentDay: Int {
        let calendar = Calendar.autoupdatingCurrent
        let components = (calendar as NSCalendar).components(.day, from: Date())
        return components.day!
    }

    /// The current hour
    public static var currentHour: Int {
        let calendar = Calendar.autoupdatingCurrent
        let components = (calendar as NSCalendar).components(.hour, from: Date())
        return components.hour!
    }

    /// The current minute
    public static var currentMinute: Int {
        let calendar = Calendar.autoupdatingCurrent
        let components = (calendar as NSCalendar).components(.minute, from: Date())
        return components.minute!
    }

    /// The current second
    public static var currentSecond: Int {
        let calendar = Calendar.autoupdatingCurrent
        let components = (calendar as NSCalendar).components(.second, from: Date())
        return components.second!
    }

    /// The era component of self
    public var era: Int {
        return components.era!
    }

    /// The year component of self
    public  var year: Int {
        return components.year!
    }

    /// The month component of self
    public  var month: Int {
        return components.month!
    }

    /// The day component of self
    public  var day: Int {
        return components.day!
    }

    /// The hour component of self
    public  var hour: Int {
        return components.hour!
    }

    /// The minute component of self
    public  var minute: Int {
        return components.minute!
    }

    /// The second component of self
    public  var second: Int {
        return components.second!
    }

    /// The weekday component of self
    public  var weekday: Int {
        return components.weekday!
    }

    /// The weekdayOrdinal component of self
    public  var weekdayOrdinal: Int {
        return components.weekdayOrdinal!
    }

    /// The quarter component of self
    public  var quarter: Int {
        return components.quarter!
    }

    /// The weekOfMonth component of self
    public  var weekOfMonth: Int {
        return components.weekOfMonth!
    }

    /// The weekOfYear component of self
    public  var weekOfYear: Int {
        return components.weekOfYear!
    }

    /// The yearForWeekOfYear component of self
    public  var yearForWeekOfYear: Int {
        return components.yearForWeekOfYear!
    }

    /// The nanosecond component of self
    public  var nanosecond: Int {
        return components.nanosecond!
    }

    /// The calendar component of self
    public  var calendar: Calendar? {
        return (components as NSDateComponents).calendar
    }

    /// The timeZone component of self
    public  var timeZone: TimeZone? {
        return (components as NSDateComponents).timeZone
    }

    /**
     The time, formatted with a specified TimeFormat.

     Format options:
     - `HourMinuteMilitary` (e.g. "19:41")
     - `HourMinutePeriod` (e.g. "07:41 PM")
     - `HourMinuteSecondMilitary` (e.g. "19:41:30")
     - `HourMinuteSecondPeriod` (e.g. "07:41:30 PM")

     Default format is `HourMinuteMilitary`.

     - parameter format: The format to use for the time (optional).

     - returns: The formatted time string.
     */
    public  func time(_ format: TimeFormat = .hourMinuteMilitary) -> String {
        return format.convert(hour: hour, minute: minute, second: second)
    }
}

// MARK: Private

extension Date {

    fileprivate  var autoupdatingCurrentCalendar: Calendar {
        return Calendar.autoupdatingCurrent
    }

    fileprivate  var allCalendarComponents: NSCalendar.Unit {
        return [
            .era,
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second,
            .weekday,
            .weekdayOrdinal,
            .quarter,
            .weekOfMonth,
            .weekOfYear,
            .yearForWeekOfYear,
            .nanosecond,
            .calendar,
            .timeZone
        ]
    }

    fileprivate var components: DateComponents {
        return (autoupdatingCurrentCalendar as NSCalendar).components(allCalendarComponents, from: self)
    }
}

// MARK: Comparable

//extension Date: Comparable {}

/// Returns true if both dates are equal to each other.
public func == (lhs: Date, rhs: Date) -> Bool {

    return lhs.timeIntervalSinceNow == rhs.timeIntervalSinceNow  || lhs.compare(rhs) == .orderedSame
    //return lhs === rhs || lhs.compare(rhs) == .orderedSame
}

/// Returns true if the first date is less than the second date.
public func < (lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedAscending
}
