//
//  GCD.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/7/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import Foundation

public func dp_main(_ wait: Bool = true, block: (()->Void)?) {
    if let block = block{
        if wait {
            if Thread.isMainThread {
                block()
            } else {
                DispatchQueue.main.sync(execute: block)
            }
        } else {
            DispatchQueue.main.async(execute: block)
        }
    }
}

public func dp_background(_ wait: Bool = false, block: (()->Void)?) {
    if let block = block {
        if wait {
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).sync(execute: block)
        } else {
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: block)
        }
    }
}

public func dp_after(_ seconds: Double, block: (()->Void)?) {
    if let block = block {
        let nsec = Int64(seconds * Double(NSEC_PER_SEC))
        let time = DispatchTime.now() + Double(nsec) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: block)
    }
}

public func wait(_ block: () -> Bool) {
    while !block() && RunLoop.current.run(mode: RunLoopMode.defaultRunLoopMode, before: Date.distantFuture) {}
}

public func wait(_ sec: TimeInterval) {
    var done = false
    dp_after(sec) { () -> Void in
        done = true
    }
    while !done && RunLoop.current.run(mode: RunLoopMode.defaultRunLoopMode, before: Date.distantFuture) {}
}
