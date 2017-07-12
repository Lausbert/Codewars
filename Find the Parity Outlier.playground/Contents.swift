import XCTest

func findOutlier(_ array: [Int]) -> Int {
    
    var numOdd = 0; var numEven = 0
    
    for int in array[0...2] {
        if int % 2 == 0 {
            numEven += 1
        } else {
            numOdd += 1
        }
    }
    
    let add = numOdd > numEven ? 0 : 1
    
    for int in array {
        if (int + add) % 2 == 0 {return int}
    }
    
    return 0
}

public struct TestRunner {
    
    public init() {}
    
    public func runTest(testClass: AnyClass) {
        let tests = testClass as! XCTestCase.Type
        let testSuite = tests.defaultTestSuite
        testSuite.run()
        _  = testSuite.testRun as! XCTestSuiteRun
    }
}

class SolutionTest: XCTestCase {
    static var allTests = [
        ("Sample tests", sampleTestCase),
        ]
    
    func sampleTestCase() {
        XCTAssertEqual(findOutlier([1, 33, 10053359313, 2, 1, 1, 1, 1, 1, 1, -3, 9]), 2)
        XCTAssertEqual(findOutlier([8, 80, 14, 2, 20, 0, 21, 80]), 21)
    }
}

TestRunner().runTest(testClass: SolutionTest.self)
