import Foundation

func expandedForm(_ num: Int) -> String {
    let characters = String(num).characters
    let indices = stride(from: characters.count, to: 0, by: -1).map{pow(10.0,Double($0-1))}
    let expandedForm = zip(characters,indices).map{Int("\($0.0)") == 0 ? "" : "\(Int("\($0.0)")!*Int($0.1)) + "}.joined()
    return expandedForm.substring(to: expandedForm.index(expandedForm.endIndex, offsetBy: -3))
}

func expandedForm1(_ num: Int) -> String {
    let digits = String(num).characters
    return digits.enumerated().flatMap { $1 == "0" ? nil : "\($1)" + String(repeating: "0", count: digits.count - $0 - 1) }.joined(separator: " + ")
}

func expandedForm2(_ num: Int) -> String {
    let digits = String(num).characters
    let maxZeros = digits.count - 1
    
    let parts = digits
        .enumerated()
        .filter { $0.element != "0" }
        .map { String($0.element) + String(repeating: "0", count: maxZeros - $0.offset) }
    
    return parts.joined(separator: " + ")
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

class ExampleTest: XCTestCase {
    static let testValues = [
        (12, "10 + 2"),
        (42, "40 + 2"),
        (70304, "70000 + 300 + 4")
    ]
    
    static var allTests = [
        ("Simple Tests", tests),
        ]
    
    func tests() {
        for test in ExampleTest.testValues {
            XCTAssertEqual(expandedForm(test.0), test.1)
        }
    }
}

TestRunner().runTests(testClass: ExampleTest.self)
