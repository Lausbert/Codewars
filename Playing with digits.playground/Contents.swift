import Foundation

func digPow(for number: Int, using power: Int) -> Int {
    let digits = String("\(number)")?.characters
    let sum = digits?.enumerated().flatMap({Int(pow(Double("\($1)")!, Double($0+power)))}).reduce(0,+)
    return sum!%number == 0 ? sum!/number : -1
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
        XCTAssertEqual(digPow(for: 89, using: 1), 1)
        XCTAssertEqual(digPow(for: 92, using: 1), -1)
        XCTAssertEqual(digPow(for: 46288, using: 3), 51)
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
