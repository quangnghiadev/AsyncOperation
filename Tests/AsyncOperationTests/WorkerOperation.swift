//
//  WorkerOperation.swift
//  AsyncOperationTests
//
//  Created by Nghia Nguyen on 21/03/2021.
//

@testable import AsyncOperation
import Foundation

typealias WorkerCallback = () -> Void

final class WorkerOperation: AsyncOperation {
    var task: ((@escaping WorkerCallback) -> Void)?

    init(task: ((@escaping WorkerCallback) -> Void)?) {
        self.task = task
    }

    override func main() {
        task? { [weak self] in
            self?.finish()
        }
    }
}
