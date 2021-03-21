import XCTest
@testable import AsyncOperation

final class AsyncOperationTests: XCTestCase {
    private var worker: WorkerOperation!
    private let operationQueue = OperationQueue()
    
    override func tearDown() {
        super.tearDown()
        worker = nil
    }
    
    
    func testCallingAsyncTask() {
        let expect = expectation(description: "async worker")
        worker = WorkerOperation(task: { callback in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                callback()
                expect.fulfill()
            }
        })
        
        XCTAssertTrue(worker.isAsynchronous)
        
        operationQueue.addOperation(worker)
        
        wait(for: [expect], timeout: 2.0)
        XCTAssertEqual(worker.isFinished, true)
    }
    
    func testCancelSyncTaskBeforeFinish() {
        let expect = expectation(description: "async worker")
        worker = WorkerOperation(task: { callback in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                callback()
                expect.fulfill()
            }
        })
        
        worker.cancel()
        XCTAssertEqual(worker.isCancelled, true)
        
        operationQueue.addOperation(worker)
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 2.0)
        XCTAssertEqual(worker.isFinished, false)
    }

    static var allTests = [
        ("testExample", testCallingAsyncTask),
    ]
}
