func flatten(list: [Any]) -> [Int] {
    
    var flattenedList: [Int] = []
    
    guard !list.isEmpty else {return flattenedList}
    
    for element in list {
        switch element {
        case let element as [Any]: flattenedList += flatten(list: element)
        default: flattenedList.append(element as! Int)
        }
    }
    
    return flattenedList
}

public struct TestRunner {
    
    public init() {}
    
    public func runTest(testClass: AnyClass) {
        let tests = testClass as! XCTestCase.Type
        let testSuite = tests.defaultTestSuite()
        testSuite.run()
        _ = testSuite.testRun as! XCTestSuiteRun
    }
}


import XCTest

class SolutionTest: XCTestCase {
    
    static var allTests = [
    ("Test List of Intergers", testListOfIntegers),
    ("Test Empty List", testEmptyList)
    ]
    
    func testListOfIntegers() {
        XCTAssertEqual([1,2,3,4,5,6,7,8,9], flatten(list: [1,[2,3],[4,[5,[[6,7]],8],9]]))
    }
    
    func testEmptyList() {
        XCTAssertEqual([], flatten(list: [[[]]]))
    }
}

TestRunner().runTest(testClass: SolutionTest.self)

