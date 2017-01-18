import Foundation

func dontGiveMeFive(_ start: Int, _ end: Int) -> Int {
    return (start ... end).filter{String($0).range(of: "5") == nil }.count
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
        ("Test Example", testExample),
        ]
    
    func testExample() {
        XCTAssertEqual(8, dontGiveMeFive(1,9));
        XCTAssertEqual(12, dontGiveMeFive(4,17));
    }
}

TestRunner().runTests(testClass: SolutionTest.self)