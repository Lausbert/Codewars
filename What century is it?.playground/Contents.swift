import Foundation

func whatCentury(_ year: String) -> String {
    
    var year = year
    
    if Int(year)! % 100 != 0 {
        year = String(describing: Int(year)! + 100 )
    } else {
        year = String(describing: Int(year)!)
    }
    
    if year.characters.count == 3 {
        year = "0" + year
    }
    
    var century = (year.substring(to: year.index(year.endIndex, offsetBy: -2)).characters.enumerated().map { (index, element) -> String in
        if index == 0 {return element.description}
        switch element.description {
        case "1":
            return element.description + "st"
        case "2":
            return element.description + "nd"
        case "3":
            return element.description + "rd"
        default:
            return element.description + "th"
        }
    })
    
    if century[0] == "1" {
        century[1] = century[1].substring(to: century[1].index(century[1].endIndex, offsetBy: -2)) + "th"
    }
    
    if century[0] == "0" {
        century.remove(at: 0)
    }
    
    return century.joined()
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
        XCTAssertEqual("20th", whatCentury("1999"), "With input '1999' solution produced wrong output.")
        XCTAssertEqual("21st", whatCentury("2011"), "With input '2011' solution produced wrong output.")
        XCTAssertEqual("22nd", whatCentury("2154"), "With input '2154' solution produced wrong output.")
        XCTAssertEqual("23rd", whatCentury("2259"), "With input '2259' solution produced wrong output.")
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
