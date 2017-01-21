enum Direction {
    case up
    case down
    case left
    case right
}

func superStreetFighterSelection(fighters: [[String]], position: (row: Int, column: Int), moves: [Direction]) -> [String] {
    guard moves != [] else {return []}
    var position = position
    let move = moves[0]
    while true {
        switch move {
        case .up: if position.row != 0 && fighters[position.row-1][position.column] != "" {position.row -= 1}
        case .down: if position.row != fighters.count-1 && fighters[position.row+1][position.column] != "" {position.row += 1}
        case .left: position.column = position.column != 0 ? position.column-1 : fighters[0].count-1
        case .right: position.column = position.column != fighters[0].count-1 ? position.column+1 : 0
        }
        if fighters[position.row][position.column] != "" {break}
    }
    var hoveredOver = [fighters[position.row][position.column]]
    hoveredOver.append(contentsOf: superStreetFighterSelection(fighters: fighters, position: (row: position.row, column: position.column), moves: Array(moves.dropFirst(1))))
    return hoveredOver
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
    static let fighters1 = [
        [       "",    "Ryu",  "E.Honda",  "Blanka",   "Guile", ""       ],
        [ "Balrog",    "Ken",  "Chun Li", "Zangief", "Dhalsim", "Sagat"  ],
        [   "Vega", "T.Hawk", "Fei Long",  "Deejay",   "Cammy", "M.Bison"]
    ]
    
    static let fighters2 = [
        [       "",    "Ryu",  "E.Honda",  "Cammy",  "Blanka",   "Guile",        "", "Chun Li" ],
        [ "Balrog",    "Ken",  "Chun Li",       "", "M.Bison", "Zangief", "Dhalsim", "Sagat"  ],
        [   "Vega",       "", "Fei Long", "Balrog",  "Deejay",   "Cammy",        "", "T.Hawk"]
    ]
    
    static let fighters3 = [
        [        "",     "Ryu",  "E.Honda",  "Cammy" ],
        [  "Balrog",     "Ken",  "Chun Li",       "" ],
        [    "Vega",        "", "Fei Long", "Balrog",],
        [  "Blanka",   "Guile",         "", "Chun Li"],
        [ "M.Bison", "Zangief",  "Dhalsim", "Sagat"  ],
        [  "Deejay",   "Cammy",         "", "T.Hawk" ]
    ]
    
    static let allFighters = Array(Set(fighters1.flatMap({ $0 })).union(Set(fighters2.flatMap({ $0 }))).union(Set(fighters2.flatMap({ $0 }))))
    
    static let test1: [(String, (row: Int, column: Int), [Direction], [String])] = [
        ("Should work with no selection cursor moves", (0, 0), [], []),
        ("Should stop on empty spaces vertically", (1, 0), [.up], ["Balrog"]),
        ("Should stop on empty spaces vertically", (1, 0), [.up, .up, .up, .up], ["Balrog", "Balrog", "Balrog", "Balrog"]),
        ("Should stop vertically", (1, 0), [.down, .down, .down, .down], ["Vega","Vega","Vega","Vega"]),
        ("Should stop on empty spaces vertically", (1, 5), [.up, .up, .up, .up], ["Sagat","Sagat","Sagat","Sagat"]),
        ("Should stop vertically", (1, 5), [.down, .down, .down, .down], ["M.Bison","M.Bison","M.Bison","M.Bison"]),
        ("Should rotate horizontally", (0, 2), [.left, .left, .left, .left, .left, .left, .left, .left], ["Ryu", "Guile", "Blanka", "E.Honda", "Ryu", "Guile", "Blanka", "E.Honda"]),
        ("Should rotate horizontally", (1, 3), [.left, .left, .left, .left, .left, .left, .left, .left], ["Chun Li", "Ken", "Balrog", "Sagat", "Dhalsim", "Zangief", "Chun Li", "Ken"]),
        ("Should rotate horizontally with empty spaces", (0, 2), [ .right, .right, .right, .right, .right, .right, .right, .right], ["Blanka", "Guile", "Ryu", "E.Honda", "Blanka", "Guile", "Ryu", "E.Honda"]),
        ("Should rotate on all rows", (0, 2), [.right, .right, .right, .right, .right, .right, .down, .left, .left, .left, .left, .left, .left, .left, .left, .left, .left, .left, .left, .down, .right, .right, .right, .right, .right, .right, .right, .right, .right, .right, .right, .right], ["Blanka", "Guile", "Ryu", "E.Honda", "Blanka", "Guile", "Dhalsim", "Zangief", "Chun Li", "Ken", "Balrog", "Sagat", "Dhalsim", "Zangief", "Chun Li", "Ken", "Balrog", "Sagat", "Dhalsim", "Cammy", "M.Bison", "Vega", "T.Hawk", "Fei Long", "Deejay", "Cammy", "M.Bison", "Vega", "T.Hawk", "Fei Long", "Deejay", "Cammy"])
    ]
    
    static let test2: [(String, (row: Int, column: Int), [Direction], [String])] = [
        ("Should rotate on all rows", (0, 2), [.right, .right, .right, .right, .right, .right, .down, .left, .left, .left, .left, .left, .left, .left, .left, .left, .left, .left, .left, .down, .right, .right, .right, .right, .right, .right, .right, .right, .right, .right, .right, .right], ["Cammy", "Blanka", "Guile", "Chun Li", "Ryu", "E.Honda", "Chun Li", "Ken", "Balrog", "Sagat", "Dhalsim", "Zangief", "M.Bison", "Chun Li", "Ken", "Balrog", "Sagat", "Dhalsim", "Zangief", "Cammy", "T.Hawk", "Vega", "Fei Long", "Balrog", "Deejay", "Cammy", "T.Hawk", "Vega", "Fei Long", "Balrog", "Deejay", "Cammy"]),
        ("Should work", (0, 3), [.down, .right, .right, .right, .down, .left, .left, .down, .right, .right, .right, .up], ["Cammy", "Blanka", "Guile", "Chun Li", "Sagat", "Dhalsim", "Zangief", "Cammy", "T.Hawk", "Vega", "Fei Long", "Chun Li"])
    ]
    
    static let test3: [(String, (row: Int, column: Int), [Direction], [String])] = [
        ("Should work with longer grid", (0, 3), [.left, .left, .down, .right, .right, .right, .right, .down, .left, .left, .left, .left, .down, .right, .right,  .down, .right, .right, .right, .down, .left, .left, .left, .down, .left, .left, .left], ["E.Honda", "Ryu", "Ken", "Chun Li", "Balrog", "Ken", "Chun Li", "Fei Long", "Vega", "Balrog", "Fei Long", "Vega", "Blanka", "Guile", "Chun Li", "Sagat", "M.Bison", "Zangief", "Dhalsim", "Dhalsim", "Zangief", "M.Bison", "Sagat", "T.Hawk", "Cammy", "Deejay", "T.Hawk"]),
        ("Should work with odd initial position", (3, 3), [.left, .left, .down, .right, .right, .right, .right, .down, .left, .left, .left, .left, .up, .right, .right, .up, .right, .right, .right], ["Guile", "Blanka", "M.Bison", "Zangief", "Dhalsim", "Sagat", "M.Bison", "Deejay", "T.Hawk", "Cammy", "Deejay", "T.Hawk", "Sagat", "M.Bison", "Zangief", "Guile", "Chun Li", "Blanka", "Guile"])
    ]
    
    static var allTests = [
        ("Character Selection", characterSelection)
    ]
    
    func characterSelection() {
        for test in SolutionTest.test1 {
            XCTAssertEqual(superStreetFighterSelection(fighters: SolutionTest.fighters1, position: test.1, moves: test.2), test.3, test.0)
        }
        for test in SolutionTest.test2 {
            XCTAssertEqual(superStreetFighterSelection(fighters: SolutionTest.fighters2, position: test.1, moves: test.2), test.3, test.0)
        }
        for test in SolutionTest.test3 {
            XCTAssertEqual(superStreetFighterSelection(fighters: SolutionTest.fighters3, position: test.1, moves: test.2), test.3, test.0)
        }
    }
}

TestRunner().runTests(testClass: SolutionTest.self)