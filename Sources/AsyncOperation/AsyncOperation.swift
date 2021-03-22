//
//  AsyncOperation.swift
//  AsyncOperation
//
//  Created by Nghia Nguyen on 4/15/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Foundation

open class AsyncOperation: Operation {
    public enum State: String {
        case ready, executing, finished

        fileprivate var keyPath: String {
            return "is\(rawValue.capitalized)"
        }
    }

    public var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }

    override public var isReady: Bool {
        return super.isReady && state == .ready
    }

    override public var isExecuting: Bool {
        return state == .executing
    }

    override public var isFinished: Bool {
        return state == .finished
    }

    override public var isAsynchronous: Bool {
        return true
    }

    override public func start() {
        guard !isCancelled else {
            finish()
            return
        }
        if !isExecuting {
            state = .executing
        }
        main()
    }

    public func finish() {
        if isExecuting {
            state = .finished
        }
    }

    override open func cancel() {
        super.cancel()
        finish()
    }
}
