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

func removeDuplicates(head:Node?) -> Node? {
    head?.next = removeDuplicates(head: head?.next)
    return head?.data == head?.next?.data ? head?.next : head
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
        ("testRemoveDuplicates", testRemoveDuplicates),
        ("testRemoveDuplicatesWithNilList", testRemoveDuplicatesWithNilList),
        ("testRemoveDuplicatesWithoutDuplicates", testRemoveDuplicatesWithoutDuplicates),
        ("testRemoveDuplicatesWithMultipleDuplicateSetsInMiddle", testRemoveDuplicatesWithMultipleDuplicateSetsInMiddle),
        ("testRemoveDuplicatesWithDuplicatesAtEnd", testRemoveDuplicatesWithDuplicatesAtEnd),
        
        ]
    
    func testRemoveDuplicates() {
        var first:Node? = buildListFromArray([1, 1, 1, 2, 3])
        first = removeDuplicates(head: first)
        XCTAssertTrue(linkedListsEqual(first: first, second: buildListFromArray([1, 2, 3])))
    }
    
    func testRemoveDuplicatesWithNilList() {
        var first:Node? = nil
        first = removeDuplicates(head: first)
        XCTAssertTrue(linkedListsEqual(first: first, second: nil))
    }
    
    func testRemoveDuplicatesWithoutDuplicates() {
        var first:Node? = buildOneTwoThree()
        first = removeDuplicates(head: first)
        XCTAssertTrue(linkedListsEqual(first: first, second: buildOneTwoThree()))
    }
    
    func testRemoveDuplicatesWithMultipleDuplicateSetsInMiddle() {
        var first:Node? = buildListFromArray([1, 2, 3, 3, 3, 4, 5, 5, 5, 6, 7])
        first = removeDuplicates(head: first)
        XCTAssertTrue(linkedListsEqual(first: first, second: buildListFromArray([1, 2, 3, 4, 5, 6, 7])))
    }
    
    func testRemoveDuplicatesWithDuplicatesAtEnd() {
        var first:Node? = buildListFromArray([1, 2, 3, 4, 5, 5, 5, 5, 5])
        first = removeDuplicates(head: first)
        XCTAssertTrue(linkedListsEqual(first: first, second: buildListFromArray([1, 2, 3, 4, 5])))
    }
}
TestRunner().runTests(testClass: SolutionTest.self)
