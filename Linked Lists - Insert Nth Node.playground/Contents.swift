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

enum insertNthError: Error {
    case InvalidArgumentException
}

func insertNth(_ head: Node?, _ index: Int, _ data: Int) throws -> Node? {
    if head == nil && index != 0 {
        throw insertNthError.InvalidArgumentException
    }
    if index == 0 {
        return push(head, data)
    }
    head?.next = try insertNth(head?.next, index - 1, data)
    return head
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
        ("testInsertNthNodeWithZeroIndex", testInsertNthNodeWithZeroIndex),
        ("testInsertNthNodeWithNoneZeroIndex", testInsertNthNodeWithNoneZeroIndex),
        ("testInsertNthNodeAtEndOfList", testInsertNthNodeAtEndOfList),
        ("testInsertNthNodeWithInvalidIndex", testInsertNthNodeWithInvalidIndex),
        ]
    
    let list:Node? = buildOneTwoThree()
    let largeList:Node? = buildListFromArray([8, 4, 1, 2, 9, 4, 2, 8, 2])
    
    func testInsertNthNodeWithZeroIndex() {
        var head = try! insertNth(list, 0, 7)
        XCTAssertTrue(linkedListsEqual(first: head, second: buildListFromArray([7, 1, 2, 3])))
        head = try! insertNth(nil, 0, 7)
        XCTAssertTrue(linkedListsEqual(first: head, second: buildListFromArray([7])))
    }
    
    func testInsertNthNodeWithNoneZeroIndex() {
        var head = try! insertNth(list, 2, 7)
        XCTAssertTrue(linkedListsEqual(first: head, second: buildListFromArray([1, 2, 7, 3])))
        head = try! insertNth(largeList, 4, 13)
        XCTAssertTrue(linkedListsEqual(first: head, second: buildListFromArray([8, 4, 1, 2, 13, 9, 4, 2, 8, 2])))
    }
    
    func testInsertNthNodeAtEndOfList() {
        let head = try! insertNth(list, 3, 7)
        XCTAssertEqual(head?.next?.next?.next?.data, 7)
    }
    
    func testInsertNthNodeWithInvalidIndex() {
        XCTAssertThrowsError(try insertNth(list, 4, 7))
    }
}

TestRunner().runTests(testClass: SolutionTest.self)