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

func insertSort(head: Node?) -> Node? {
    if head == nil {return nil}
    if head?.next == nil {return push(nil, (head?.data)!)}
    return sortedInsert(insertSort(head: head?.next), (head?.data)!)
}

func sortedInsert(_ head: Node?, _ data: Int) -> Node? {
    if head == nil || (head?.data)! >= data {return push(head, data)}
    head?.next = sortedInsert(head?.next, data)
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
        ("testInsertSortWithNilList", testInsertSortWithNilList),
        ("testInsertSort", testInsertSort),
        ("testInsertSortSingleItem", testInsertSortSingleItem),
        ]
    
    func testInsertSortWithNilList() {
        var head:Node?
        head = insertSort(head: head)
        XCTAssertNil(head)
    }
    
    func testInsertSort() {
        var head:Node? = buildListFromArray([5, 2, 1, 5, 2, 8, 9])
        head = insertSort(head: head)
        XCTAssertTrue(linkedListsEqual(first: head, second: buildListFromArray([1, 2, 2, 5, 5, 8, 9])))
    }
    
    func testInsertSortSingleItem() {
        var head:Node? = buildListFromArray([5])
        head = insertSort(head: head)
        XCTAssertTrue(linkedListsEqual(first: head, second: buildListFromArray([5])))
    }
}

TestRunner().runTests(testClass: SolutionTest.self)