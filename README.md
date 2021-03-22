
[![Build Status](https://github.com/quangnghiadev/AsyncOperation/workflows/Swift/badge.svg?branch=main)](https://github.com/quangnghiadev/AsyncOperation/actions)
[![SPM compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)
[![Swift](https://img.shields.io/badge/Swift-5.3-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-12.2-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

**AsyncOperation** is a custom class for create Asynchronous Operation for OperationQueue

## Requirements

- **iOS** 11.0+
- Swift 5.0+


## Installation

### Swift Package Manager
You can use The Swift Package Manager to install AsyncOperation by adding `https://github.com/quangnghiadev/AsyncOperation.git` to Swift Package of your XCode project

## Usage

Create your sub class of AsyncOperation with async task on `main` function. For example, `WorkerOperation` below receive a closure for run async task.

```swift
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
```

Create an instance and add it into operation queue

```swift
private var worker: WorkerOperation = WorkerOperation(task: { callback in
                        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                            callback()
                        }
                    })
private let operationQueue = OperationQueue()
operationQueue.addOperation(worker)
```

That's all!


## License
- AsyncOperation is released under the MIT license. See [LICENSE](https://github.com/quangnghiadev/AsyncOperation/blob/master/LICENSE) for more information.
    
