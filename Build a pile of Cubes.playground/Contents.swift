import Foundation

func findNb(_ number: Int) -> Int {
    return findNbHelper(number, 1)
}

func findNbHelper(_ number: Int,_ base: Int) -> Int {
    let cube = Int(pow(Double(base), 3.0))
    guard cube < number else {return cube == number ? 1 : -1}
    let findNbH = findNbHelper(number-cube, base + 1)
    return findNbH == -1 ? -1 : findNbH + 1
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
        XCTAssertEqual(findNb(4183059834009), 2022)
        XCTAssertEqual(findNb(24723578342962), -1)
        XCTAssertEqual(findNb(135440716410000), 4824)
        XCTAssertEqual(findNb(40539911473216), 3568)
        XCTAssertEqual(findNb(26825883955641), 3218)
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
