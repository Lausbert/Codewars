//credits to timvermeulen; tried problem again after I have seen and understood his solution

func diamond(_ size: Int) -> String? {
    guard size%2 == 1 && size > 0 else {return nil }
    
    let spaceCounts = (1 ... size / 2).reversed()
    let starCounts = stride(from:1, to: size, by: 2)
    
    let lines = zip(spaceCounts,starCounts).map { spaceCount, StarCount in
        return(String(repeating: " ", count: spaceCount) + String(repeating: "*", count: StarCount) + "\n")
    }
    return lines.joined() + String(repeating: "*", count: size) + "\n" + lines.reversed().joined()
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
        XCTAssertEqual(diamond(3)!, " *\n***\n *\n")
        XCTAssertEqual(diamond(2), nil)
        XCTAssertEqual(diamond(-3), nil)
        XCTAssertEqual(diamond(0), nil)
    }
}

TestRunner().runTests(testClass: SolutionTest.self)