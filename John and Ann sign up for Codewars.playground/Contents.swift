enum person {
    case ann
    case jonn
}

func ann(_ n : Int) -> [Int] {
    return both(n, person: person.ann)
}

func john(_ n : Int) -> [Int] {
    return both(n, person: person.jonn)
}

func both(_ n : Int, person: person) -> [Int] {
    
    var d = 1
    var a = [1], j = [0]
    
    while d < n {
        
        j.append(d - a[j[d-1]])
        a.append(d - j[a[d-1]])
        
        d += 1
    }
    
    switch person {
    case .ann: return a
    case .jonn: return j
    }
}

func sumJohn(_ n : Int) -> Int {
    return john(n).reduce(0, +)
}

func sumAnn(_ n : Int) -> Int {
    return ann(n).reduce(0, +)
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
        ("Test Examples", testExample),
        ]
    
    func testExample() {
        XCTAssertEqual(ann(1), [1])
        XCTAssertEqual(john(1), [0])
        XCTAssertEqual(ann(6), [1, 1, 2, 2, 3, 3])
        XCTAssertEqual(john(11), [0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6])
        XCTAssertEqual(ann(15), [1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9])
        XCTAssertEqual(john(15), [0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 7, 8, 9])
        XCTAssertEqual(sumAnn(1), 1)
        XCTAssertEqual(sumJohn(1), 0)
        XCTAssertEqual(sumAnn(100), 3076)
        XCTAssertEqual(sumJohn(100), 3066)
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
