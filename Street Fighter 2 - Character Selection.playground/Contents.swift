enum Direction {
    case up
    case down
    case left
    case right
}

func streetFighterSelection(fighters: [[String]], position: (row: Int, column: Int), moves: [Direction]) -> [String] {
    guard moves != [] else {return []}
    var position = position
    let move = moves[0]
    switch move {
    case .up: if position.row != 0 {position.row -= 1}
    case .down: if position.row != fighters.count-1 {position.row += 1}
    case .left: position.column = position.column != 0 ? position.column-1 : fighters[0].count-1
    case .right: position.column = position.column != fighters[0].count-1 ? position.column+1 : 0
    }
    var hoveredOver = [fighters[position.row][position.column]]
    hoveredOver.append(contentsOf: streetFighterSelection(fighters: fighters, position: (row: position.row, column: position.column), moves: Array(moves.dropFirst(1))))
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

class ExampleTest: XCTestCase {
    static let fighters = [
        ["Ryu", "E.Honda",  "Blanka",   "Guile", "Balrog", "Vega"],
        ["Ken", "Chun Li", "Zangief", "Dhalsim",  "Sagat", "M.Bison"]
    ]
    
    static let characterTest: [(String, (row: Int, column: Int), [Direction], [String])] = [
        ("Should work with no selection cursor moves", (0, 0), [], []),
        ("Should work with few moves", (0, 0), [.up, .left, .right, .left, .left], ["Ryu", "Vega", "Ryu", "Vega", "Balrog"]),
        ("Should work when always moving left", (0, 0), [.left, .left, .left, .left, .left, .left, .left, .left], ["Vega", "Balrog", "Guile", "Blanka", "E.Honda", "Ryu", "Vega", "Balrog"]),
        ("Should work when always moving right", (0, 0), [.right, .right, .right, .right, .right, .right, .right, .right], ["E.Honda", "Blanka", "Guile", "Balrog", "Vega", "Ryu", "E.Honda", "Blanka"]),
        ("Should use all 4 directions clockwise twice", (0, 0), [.up, .left, .down, .right, .up, .left, .down, .right], ["Ryu", "Vega", "M.Bison", "Ken", "Ryu", "Vega", "M.Bison", "Ken"]),
        ("Should work when always moving down", (0, 0), [.down, .down, .down, .down], ["Ken", "Ken", "Ken", "Ken"]),
        ("Should work when always moving up", (0, 0), [.up, .up, .up, .up], ["Ryu", "Ryu", "Ryu", "Ryu"])
    ]
    
    static var allTests = [
        ("Character Selection", characterSelection)
    ]
    
    func characterSelection() {
        for test in ExampleTest.characterTest {
            XCTAssertEqual(streetFighterSelection(fighters: ExampleTest.fighters, position: test.1, moves: test.2), test.3, test.0)
        }
    }
}

TestRunner().runTests(testClass: ExampleTest.self)