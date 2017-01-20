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

func sortedMerge(first:Node?, second:Node?) -> Node? {
    return insertSort(head: append(first, second))
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

func append(_ listA:Node?, _ listB:Node?) -> Node? {
    guard listA != nil else {return listB}
    listA?.next = append(listA?.next, listB)
    return listA
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
        ("testSortedMergeBothListsAreNil", testSortedMergeBothListsAreNil),
        ("testSortedMergeBothListsFirstItemIsNil", testSortedMergeBothListsFirstItemIsNil),
        ("testSortedMergeBothListsSecondItemIsNil", testSortedMergeBothListsSecondItemIsNil),
        ("testSortedMergeBothListsHaveOneItem", testSortedMergeBothListsHaveOneItem),
        ("testSortedMergeBothListsHaveTwoItems", testSortedMergeBothListsHaveTwoItems),
        ("testSortedMergeFirstListShorterThanTheOther", testSortedMergeFirstListShorterThanTheOther),
        ("testSortedMergeSecondListShorterThanTheOther", testSortedMergeSecondListShorterThanTheOther),
        ("testSortedMergeTwoLargeLists", testSortedMergeTwoLargeLists),
        ]
    
    func testSortedMergeBothListsAreNil() {
        let first:Node? = nil
        let second:Node? = nil
        let result:Node? = sortedMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: nil))
    }
    
    func testSortedMergeBothListsFirstItemIsNil() {
        let first:Node? = nil
        let second:Node? = Node(2)
        let result:Node? = sortedMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([2])))
    }
    
    func testSortedMergeBothListsSecondItemIsNil() {
        let first:Node? = Node(1)
        let second:Node? = nil
        let result:Node? = sortedMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1])))
    }
    
    func testSortedMergeBothListsHaveOneItem() {
        let first:Node? = Node(1)
        let second:Node? = Node(2)
        let result:Node? = sortedMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 2])))
    }
    
    func testSortedMergeBothListsHaveTwoItems() {
        let first:Node? = buildListFromArray([1, 2])
        let second:Node? = buildListFromArray([3, 4])
        let result:Node? = sortedMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 2, 3, 4])))
    }
    
    func testSortedMergeFirstListShorterThanTheOther() {
        let first:Node? = buildListFromArray([1])
        let second:Node? = buildListFromArray([3, 4, 5, 6])
        let result:Node? = sortedMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 3, 4, 5, 6])))
    }
    
    func testSortedMergeSecondListShorterThanTheOther() {
        let first:Node? = buildListFromArray([1, 3, 5, 7, 8, 12])
        let second:Node? = buildListFromArray([6])
        let result:Node? = sortedMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 3, 5, 6, 7, 8, 12])))
    }
    
    func testSortedMergeTwoLargeLists() {
        let first:Node? = buildListFromArray([5, 8, 9, 12, 15, 15, 17, 23, 44])
        let second:Node? = buildListFromArray([2, 3, 5, 5, 6, 7, 9, 13, 55])
        let result:Node? = sortedMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray(
            [2, 3, 5, 5, 5, 6, 7, 8, 9, 9, 12, 13, 15, 15, 17, 23, 44, 55]))
        )
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
