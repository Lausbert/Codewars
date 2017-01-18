// Credits to SuperGlenn; I resubmitted my solution after I have seen and understood his solution

func dashatize(_ number: Int) -> String {
    let number = number < 0 ? -number : number
    var string = (String(number).characters.map {Int(String($0))! % 2 == 0 ? "\($0)" : "-\($0)-" }).joined()
    if string.characters.first == "-" {string.remove(at: string.startIndex)}
    if string.characters.last == "-" {string.remove(at: string.index(before: string.endIndex))}
    return string.replacingOccurrences(of: "--", with: "-")
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
        XCTAssertEqual(dashatize(274),"2-7-4", "Should return 2-7-4")
        XCTAssertEqual(dashatize(5311),"5-3-1-1", "Should return 5-3-1-1")
        XCTAssertEqual(dashatize(86320),"86-3-20", "Should return 86-3-20")
        XCTAssertEqual(dashatize(974302),"9-7-4-3-02", "Should return 9-7-4-3-02")
        
        XCTAssertEqual(dashatize(0),"0", "Should return 0")
        XCTAssertEqual(dashatize(-1),"1", "Should return 1")
        XCTAssertEqual(dashatize(-28369),"28-3-6-9", "Should return 28-3-6-9")
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
