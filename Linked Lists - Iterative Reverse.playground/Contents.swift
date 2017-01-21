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

func reverse(list:inout Node?) {
    
    var first: Node?
    var third: Node?
    
    while list != nil {
        third = list?.next
        list?.next = first
        first = list
        list = third
    }
    list = first
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
        ("testIterativeReverseEmptyList", testIterativeReverseEmptyList),
        ("testIterativeReverseOneItem", testIterativeReverseOneItem),
        ("testIterativeReverseTwoItems", testIterativeReverseTwoItems),
        ("testIterativeReverseFiveItems", testIterativeReverseFiveItems),
        ("testIterativeReverseSeveralItems", testIterativeReverseSeveralItems),
        ]
    
    func testIterativeReverseEmptyList() {
        var list:Node?
        reverse(list: &list)
        XCTAssertNil(list)
    }
    
    func testIterativeReverseOneItem() {
        var list:Node? = Node(2)
        reverse(list: &list)
        XCTAssertTrue(linkedListsEqual(first: list, second: buildListFromArray([2])))
    }
    
    func testIterativeReverseTwoItems() {
        var list:Node? = buildListFromArray([4, 9])
        reverse(list: &list)
        XCTAssertTrue(linkedListsEqual(first: list, second: buildListFromArray([9, 4])))
    }
    
    func testIterativeReverseFiveItems() {
        var list:Node? = buildListFromArray([2, 1, 3, 6, 5])
        reverse(list: &list)
        XCTAssertTrue(linkedListsEqual(first: list, second: buildListFromArray([5, 6, 3, 1, 2])))
    }
    
    func testIterativeReverseSeveralItems() {
        var list:Node? = buildListFromArray([9, 32, 4, 1, 35, 13, 41, 9, 42, 1, 7, 5, 4])
        reverse(list: &list)
        XCTAssertTrue(linkedListsEqual(first: list, second: buildListFromArray(
            [4, 5, 7, 1, 42, 9, 41, 13, 35, 1, 4, 32, 9]))
        )
    }
}

TestRunner().runTests(testClass: SolutionTest.self)