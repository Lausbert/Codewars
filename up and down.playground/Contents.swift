func arrange(_ s: String) -> String {
    
    var sArr = s.components(separatedBy: " ")
    
    for i in 0...sArr.count-1 {
        
        let l1 = sArr[i].characters.count
        let l2 = i != sArr.count-1 ? sArr[i+1].characters.count : 0
        
        if i%2==0 {
            if l1>l2 && l2 != 0 {swap(&sArr[i], &sArr[i+1])}
            sArr[i] = sArr[i].lowercased()
        } else {
            if l1<l2 && l2 != 0 {swap(&sArr[i], &sArr[i+1])}
            sArr[i] = sArr[i].uppercased()
        }
    }
    
    return sArr.joined(separator: " ")
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
        ("arrange", testExample),
        ]
    
    func testing(_ s: String, _ expected: String) {
        XCTAssertEqual(arrange(s), expected)
    }
    
    func testExample() {
        testing("who hit retaining The That a we taken", "who RETAINING hit THAT a THE we TAKEN") // 3
        testing("on I came up were so grandmothers", "i CAME on WERE up GRANDMOTHERS so") // 4
        testing("way the my wall them him", "way THE my WALL him THEM") // 1
        testing("turn know great-aunts aunt look A to back", "turn GREAT-AUNTS know AUNT a LOOK to BACK") // 2
    }
}

TestRunner().runTests(testClass: SolutionTest.self)