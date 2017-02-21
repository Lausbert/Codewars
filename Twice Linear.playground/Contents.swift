func dblLinear(_ n: Int) -> Int {

    var x = 1, yIndex = 0, zIndex = 0
    var y = [1], z: [Int] = []
    
    for _ in 0...Int(Double(n)/2.272727272727272707195) { //2.27...=25/11 Seriously, I have no clue if this has any deeper meaning :)
        y.append(2*x+1)
        z.append(3*x+1)
       dontRepeatYourself(y: y, z: z, yIndex: &yIndex , zIndex: &zIndex, x: &x)
    }
    
    while y.last! < z.last! {
        y.append(2*x+1)
        dontRepeatYourself(y: y, z: z, yIndex: &yIndex , zIndex: &zIndex, x: &x)
    }
    
    x = 1; yIndex = 0; zIndex = 0
    
    for _ in 0...n-1 {
        dontRepeatYourself(y: y, z: z, yIndex: &yIndex , zIndex: &zIndex, x: &x)
    }
    
    return x
}

func dontRepeatYourself(y: [Int], z: [Int], yIndex: inout Int, zIndex: inout Int, x: inout Int) {
    while y[yIndex] <= x {yIndex += 1}
    while z[zIndex] <= x {zIndex += 1}
    let yTemp = y[yIndex]
    let zTemp = z[zIndex]
    x = yTemp < zTemp ? yTemp : zTemp
}

import XCTest

// XCTest Spec Example:
// TODO: replace with your own tests (TDD), these are just how-to examples to get you started

class SolutionTest: XCTestCase {
    static var allTests = [
        ("dblLinear", testExample),
        ]
    
    func testing(_ n: Int, _ expected: Int) {
        XCTAssertEqual(dblLinear(n), expected)
    }
    
    func testExample() {
        testing(10, 22)
        testing(20, 57)
        testing(30, 91)
        testing(50, 175)
        testing(100, 447)
        testing(500, 3355)
    }
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

TestRunner().runTests(testClass: SolutionTest.self)
