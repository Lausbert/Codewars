import Foundation

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

func recursiveReverse(list:Node?) -> Node? {
    return recursiveReverseHelper(first: nil, list: list)
}

func recursiveReverseHelper(first: Node?, list:Node?) -> Node? {
    
    var first = first
    var list = list
    var third:Node?
    
    third = list?.next
    list?.next = first
    if third == nil {return list}
    first = list
    list = third
    return recursiveReverseHelper(first: first, list: list)
}

import XCTest

func push(_ head:Node?, _ data:Int) -> Node {
    return Node(head, data)
}

func linkedListsEqual(first: Node?, second: Node?) -> Bool {
    if first?.data != second?.data {return false}
    guard first != nil else {return true}
    return linkedListsEqual(first: first?.next, second: second?.next)
}

func buildListFromArray(_ data:[Int]?) -> Node? {
    if data == nil {return nil}
    if data?.count == 1 {return push(nil, (data?[0])!)}
    return push(buildListFromArray(Array(data![1...(data!.count)-1])), (data![0]))
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

class SolutionTest: XCTestCase {
    static var allTests = [
        ("testRecursiveReverseEmptyList", testRecursiveReverseEmptyList),
        ("testRecursiveReverseOneItem", testRecursiveReverseOneItem),
        ("testRecursiveReverseTwoItems", testRecursiveReverseTwoItems),
        ("testRecursiveReverseFiveItems", testRecursiveReverseFiveItems),
        ("testRecursiveReverseSeveralItems", testRecursiveReverseSeveralItems),
        ]
    
    func testRecursiveReverseEmptyList() {
        XCTAssertNil(recursiveReverse(list: nil))
    }
    
    func testRecursiveReverseOneItem() {
        let list:Node? = Node(2)
        XCTAssertTrue(linkedListsEqual(first: recursiveReverse(list: list), second: buildListFromArray([2])))
    }
    
    func testRecursiveReverseTwoItems() {
        let list:Node? = buildListFromArray([4, 9])
        XCTAssertTrue(linkedListsEqual(first: recursiveReverse(list: list), second: buildListFromArray([9, 4])))
    }
    
    func testRecursiveReverseFiveItems() {
        let list:Node? = buildListFromArray([2, 1, 3, 6, 5])
        XCTAssertTrue(linkedListsEqual(first: recursiveReverse(list: list), second: buildListFromArray([5, 6, 3, 1, 2])))
    }
    
    func testRecursiveReverseSeveralItems() {
        let list:Node? = buildListFromArray([9, 32, 4, 1, 35, 13, 41, 9, 42, 1, 7, 5, 4])
        XCTAssertTrue(linkedListsEqual(first: recursiveReverse(list: list), second: buildListFromArray(
            [4, 5, 7, 1, 42, 9, 41, 13, 35, 1, 4, 32, 9]))
        )
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
