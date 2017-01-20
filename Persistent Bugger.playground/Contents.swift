func persistence(for num: Int) -> Int {
    if String(num).characters.count == 1 {return 0}
    let digits = String(num).characters.map {Int(String($0))!}
    return persistence(for: digits.reduce(1, *)) + 1
}

import XCTest

public struct TestRunner {
    public init() { }
    
    public func runTests(testClass:AnyClass) {
        let tests = testClass as! XCTestCase.Type
        let testSuite = tests.defaultTestSuite()
        testSuite.run()
        _ = testSuite.testRun as! XCTestSuiteRun
    }
    
}

class SolutionTest: XCTestCase {
    static var allTests = [
        ("Test Persistence", testPersistence),
        ("Test Persistence", testPersistenceAgain)
    ]
    
    func testPersistence() {
        XCTAssertEqual(persistence(for: 18), 1)
    }
    
    func testPersistenceAgain() {
        XCTAssertEqual(persistence(for: 28), 2)
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
