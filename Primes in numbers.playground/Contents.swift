func factors(_ number: Int) -> String {
    var factorDictionary:[Int:Int] = [:]
    for factor in factorHelper(number, 2) {
        factorDictionary[factor] = (factorDictionary[factor] ?? 0) + 1
    }
    return factorDictionary.sorted(by: {$0.0 < $1.0}).map{$1 == 1 ? "(\($0))" : "(\($0)**\($1))"}.joined()
}

func factorHelper(_ number: Int,_ smallestPrime: Int) -> [Int] {
    guard number > smallestPrime else {return []}
    var factors: [Int] = []
    for i in smallestPrime...number {
        if number%i == 0 {
            factors = [i]
            factors += (factorHelper(number/i, i))
            break
        }
    }
    return factors
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
        XCTAssertEqual(factors(7775460), "(2**2)(3**3)(5)(7)(11**2)(17)")
        XCTAssertEqual(factors(7919), "(7919)")
    }
}

TestRunner().runTests(testClass: SolutionTest.self)



