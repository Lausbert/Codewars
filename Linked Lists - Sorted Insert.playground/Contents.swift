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

func sortedInsert(_ head: Node?, _ data: Int) -> Node? {
    if head == nil || (head?.data)! >= data {push(head, data)}
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
        ("testSortedInsertWithNilList", testSortedInsertWithNilList),
        ("testSortedInsertWithListOfLengthOne", testSortedInsertWithListOfLengthOne),
        ("testSortedInsertWithLargeList", testSortedInsertWithLargeList),
        
        ]
    
    let largeList:Node? = buildListFromArray([1, 3, 5, 6, 7, 9, 14])
    
    func testSortedInsertWithNilList() {
        let first:Node? = sortedInsert(nil, 7)
        let second:Node? = buildListFromArray([7])
        XCTAssertTrue(linkedListsEqual(first: first, second: second))
    }
    
    func testSortedInsertWithListOfLengthOne() {
        var oneItemList = buildListFromArray([3])
        var first:Node? = sortedInsert(oneItemList, 4)
        let second:Node? = buildListFromArray([3, 4])
        XCTAssertTrue(linkedListsEqual(first: first, second: second))
        oneItemList = buildListFromArray([4])
        first = sortedInsert(oneItemList, 3)
        XCTAssertTrue(linkedListsEqual(first: first, second: second))
    }
    
    func testSortedInsertWithLargeList() {
        var first:Node? = sortedInsert(largeList, 8)
        first = sortedInsert(first, 2)
        first = sortedInsert(first, 0)
        first = sortedInsert(first, 4)
        first = sortedInsert(first, 15)
        first = sortedInsert(first, 20)
        let second:Node? = buildListFromArray([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 14, 15, 20])
        XCTAssertTrue(linkedListsEqual(first: first, second: second))
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
