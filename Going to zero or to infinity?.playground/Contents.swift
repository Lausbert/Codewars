func going(_ n: Int) -> Double {
    
    var faculties:[Int] = [1]
    
    for i in 2...n {
        faculties.append(i*faculties[i-2])
    }
    
    let result =  1.0 / Double(faculties.last!) * Double(faculties.reduce(0, +))
    
    return Double(Int(1000000*result))/1000000.0
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
        ("going", testExample),
        ]
    
    func dotest(_ n: Int, _ expected: Double) {
        XCTAssertEqual(going(n), expected)
    }
    
    func testExample() {
        dotest(5, 1.275)
        dotest(6, 1.2125)
        dotest(7, 1.173214)
        dotest(8, 1.146651)
    }
}

TestRunner().runTests(testClass: SolutionTest.self)


