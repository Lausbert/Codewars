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

enum moveNodeInPlaceError: Error {
    case sourceListOrDestListIsEmpty
}

func moveNodeInPlace(_ source:inout Node?, _ dest: inout Node?) throws {
    guard source != nil && dest != nil else {throw moveNodeInPlaceError.sourceListOrDestListIsEmpty}
    dest = push(dest, (source?.data)!)
    source = source?.next
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
        ("testMoveNodeInPlace", testMoveNodeInPlace),
        ("testMoveNodeInPlaceWithNilSource", testMoveNodeInPlaceWithNilSource),
        ("testMoveNodeInPlaceWithNilDest", testMoveNodeInPlaceWithNilDest),
        ("testMoveNodeInPlaceWithSourceAndDestNil", testMoveNodeInPlaceWithSourceAndDestNil),
        ]
    
    func testMoveNodeInPlace() {
        var source:Node? = buildOneTwoThree()
        var dest:Node? = buildListFromArray([4, 5, 6])
        try! moveNodeInPlace(&source, &dest)
        XCTAssertTrue(linkedListsEqual(first: source, second: buildListFromArray([2, 3])))
        XCTAssertTrue(linkedListsEqual(first: dest, second: buildListFromArray([1, 4, 5, 6])))
    }
    
    func testMoveNodeInPlaceWithNilSource() {
        var source:Node? = nil
        var dest:Node? = buildListFromArray([4, 5, 6])
        XCTAssertThrowsError(try moveNodeInPlace(&source, &dest))
    }
    
    func testMoveNodeInPlaceWithNilDest() {
        var source:Node? = buildOneTwoThree()
        var dest:Node? = nil
        XCTAssertThrowsError(try moveNodeInPlace(&source, &dest))
    }
    
    func testMoveNodeInPlaceWithSourceAndDestNil() {
        var source:Node? = nil
        var dest:Node? = nil
        XCTAssertThrowsError(try moveNodeInPlace(&source, &dest))
    }
}
TestRunner().runTests(testClass: SolutionTest.self)