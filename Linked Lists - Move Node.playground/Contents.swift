class Node {
    var data: Int
    var next: Node?
    
    init(_ data: Int) {
        self.data = data;
    }
    convenience init(_ next: Node?, _ data: Int)
    {
        self.init(data)
        self.next = next
    }
}

enum moveNodeError: Error {
    case sourceListIsEmpty
}

struct Context {
    var source:Node?
    var dest:Node?
}

func moveNode(source:Node?, dest:Node?) throws -> Context? {
    guard source != nil else {throw moveNodeError.sourceListIsEmpty}
    return Context(source: source?.next, dest: push(dest, (source?.data)!))
}

func buildListFromArray(_ data:[Int]?) -> Node? {
    if data == nil {return nil}
    if data?.count == 1 {return push(nil, (data?[0])!)}
    return push(buildListFromArray(Array(data![1...(data!.count)-1])), (data![0]))
}

func push(_ head:Node?, _ data:Int) -> Node {
    return Node(head, data)
}

func buildOneTwoThree() -> Node {
    return push(push(push(nil,3),2),1)
}

func linkedListsEqual(first: Node?, second: Node?) -> Bool {
    if first?.data != second?.data {return false}
    guard first != nil else {return true}
    return linkedListsEqual(first: first?.next, second: second?.next)
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
        ("testMoveNode", testMoveNode),
        ("testMoveNodeWithNilSource", testMoveNodeWithNilSource),
        ("testMoveNodeWithNilDest", testMoveNodeWithNilDest),
        ("testMoveNodeWithSourceAndDestNil", testMoveNodeWithSourceAndDestNil),
        ]
    
    func testMoveNode() {
        let source:Node? = buildOneTwoThree()
        let dest:Node? = buildListFromArray([4, 5, 6])
        let context:Context? = try! moveNode(source: source, dest: dest)
        XCTAssertTrue(linkedListsEqual(first: context?.source, second: buildListFromArray([2, 3])))
        XCTAssertTrue(linkedListsEqual(first: context?.dest, second: buildListFromArray([1, 4, 5, 6])))
    }
    
    func testMoveNodeWithNilSource() {
        let source:Node? = nil
        let dest:Node? = buildListFromArray([4, 5, 6])
        XCTAssertThrowsError(try moveNode(source: source, dest: dest))
    }
    
    func testMoveNodeWithNilDest() {
        let source:Node? = buildOneTwoThree()
        let dest:Node? = nil
        let context:Context? = try! moveNode(source: source, dest: dest)
        XCTAssertTrue(linkedListsEqual(first: context?.source, second: buildListFromArray([2, 3])))
        XCTAssertTrue(linkedListsEqual(first: context?.dest, second: buildListFromArray([1])))
    }
    
    func testMoveNodeWithSourceAndDestNil() {
        let source:Node? = nil
        let dest:Node? = nil
        XCTAssertThrowsError(try moveNode(source: source, dest: dest))
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
