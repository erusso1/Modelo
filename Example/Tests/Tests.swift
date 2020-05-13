import XCTest
import Modelo

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        User.removeAllStoredModels()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessfulResolution() {

        let post = Post(id: 1, user: 1, title: "Hey look at me!", body: "Something something dark side...")
        let exp = XCTestExpectation()
        XCTAssertNil(post.$user.storedValue)

        post.$user.resolve {
            XCTAssertNotNil($0.value)
            XCTAssertNotNil(post.$user.storedValue)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 50)
    }
    
    func testResolveSync() {
        
        let post = Post(id: 1, user: 1, title: "Hey look at me!", body: "Something something dark side...")
        
        let exp = XCTestExpectation()
        
        DispatchQueue.global(qos: .utility).async {
            
            do {
                let _ = try post.$user.resolveSync()
                XCTAssertNotNil(post.$user.storedValue)
            }
            catch{
                print(error)
                XCTAssertTrue(false)
            }
            
            exp.fulfill()
        }

        wait(for: [exp], timeout: 50)
    }
    
    func testCancelledResolution() {
        
        let post = Post(id: 1, user: 1, title: "Hey look at me!", body: "Something something dark side...")
        
        XCTAssertNil(post.$user.storedValue)

        let op = post.$user.resolve {
            XCTAssertNil($0.value)
            XCTAssert(false)
        }
        op.cancel()
        XCTAssertTrue(op.isCancelled)
        XCTAssertTrue(op.isFinished)
        XCTAssertFalse(op.isExecuting)
        Thread.sleep(forTimeInterval: 1)
        
        let op2 = post.$user.resolve {
            XCTAssertNil($0.value)
            XCTAssert(false)
        }
        let exp = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            op2.cancel()
            XCTAssertTrue(op2.isCancelled)
            XCTAssertTrue(op2.isFinished)
            exp.fulfill()
        }
        
        XCTAssertNil(post.$user.storedValue)

        wait(for: [exp], timeout: 10)
    }
}
