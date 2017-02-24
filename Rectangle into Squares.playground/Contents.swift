func sqInRect(_ lng: Int, _ wdth: Int) -> [Int]? {
    
    guard lng != wdth else {return nil}
    
    var arr:[Int] = [], lng = lng, wdth = wdth
    
    while lng != wdth {
        if lng < wdth {swap(&lng, &wdth)}
        arr.append(wdth)
        lng = lng - wdth
    }
    
    arr.append(wdth)
    
    return arr
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

class SolutionTest: XCTestCase {
    static var allTests = [
        ("sqInRect", testExample),
        ]
    
    func testing(_ lng: Int, _ wdth: Int, _ expected: [Int]?) {
        XCTAssert(sqInRect(lng, wdth)! == expected!, "should return \(expected!)")
    }
    func testingNil(_ lng: Int, _ wdth: Int) {
        XCTAssertTrue(sqInRect(lng, wdth) == nil, "Should return nil")
    }
    
    func testExample() {
        testing(5, 3, [3, 2, 1, 1])
        testing(3, 5, [3, 2, 1, 1])
        testingNil(5, 5)
        testing(20, 14, [14, 6, 6, 2, 2, 2])
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
