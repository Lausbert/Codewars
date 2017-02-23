func perimeter(_ n: UInt64) -> UInt64 {
    
    var fib = [1,1], i = 1
    
    while i < Int(n) {
        fib.append(fib[i-1]+fib[i])
        i += 1
    }
    
    return UInt64(4*fib.reduce(0, +))
}

public struct TestRunner {
    public init() { }
    
    public func runTests(testClass:AnyClass) {
        let tests = testClass as! XCTestCase.Type
        let testSuite = tests.defaultTestSuite()
        testSuite.run()
        _ = testSuite.testRun as! XCTestSuiteRun
    }
    
}

import XCTest

// XCTest Spec Example:
// TODO: replace with your own tests (TDD), these are just how-to examples to get you started

class SolutionTest: XCTestCase {
    static var allTests = [
        ("perimeter", testExample),
        ]
    
    func dotest(_ n: UInt64, _ expected: UInt64) {
        XCTAssertEqual(perimeter(n), expected)
    }
    
    func testExample() {
        dotest(5, 80);
        dotest(7, 216);
        dotest(20, 114624);
        dotest(30, 14098308);
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
