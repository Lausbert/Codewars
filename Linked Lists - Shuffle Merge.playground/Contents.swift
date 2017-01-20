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

func shuffleMerge(first: Node?, second: Node?) -> Node? {
    first?.next = shuffleMerge(first: second, second: first?.next)
    return first != nil ? first : second
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
        ("testShuffleMergeBothListsAreNil", testShuffleMergeBothListsAreNil),
        ("testShuffleMergeBothListsFirstItemIsNil", testShuffleMergeBothListsFirstItemIsNil),
        ("testShuffleMergeBothListsSecondItemIsNil", testShuffleMergeBothListsSecondItemIsNil),
        ("testShuffleMergeBothListsHaveOneItem", testShuffleMergeBothListsHaveOneItem),
        ("testShuffleMergeBothListsHaveTwoItems", testShuffleMergeBothListsHaveTwoItems),
        ("testShuffleMergeFirstListShorterThanTheOther", testShuffleMergeFirstListShorterThanTheOther),
        ("testShuffleMergeSecondListShorterThanTheOther", testShuffleMergeSecondListShorterThanTheOther),
        ("testShuffleMergeTwoLargeLists", testShuffleMergeTwoLargeLists),
        ]
    
    func testShuffleMergeBothListsAreNil() {
        let first:Node? = nil
        let second:Node? = nil
        let result:Node? = shuffleMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: nil))
    }
    
    func testShuffleMergeBothListsFirstItemIsNil() {
        let first:Node? = nil
        let second:Node? = Node(2)
        let result:Node? = shuffleMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([2])))
    }
    
    func testShuffleMergeBothListsSecondItemIsNil() {
        let first:Node? = Node(1)
        let second:Node? = nil
        let result:Node? = shuffleMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1])))
    }
    
    func testShuffleMergeBothListsHaveOneItem() {
        let first:Node? = Node(1)
        let second:Node? = Node(2)
        let result:Node? = shuffleMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 2])))
    }
    
    func testShuffleMergeBothListsHaveTwoItems() {
        let first:Node? = buildListFromArray([1, 2])
        let second:Node? = buildListFromArray([3, 4])
        let result:Node? = shuffleMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 3, 2, 4])))
    }
    
    func testShuffleMergeFirstListShorterThanTheOther() {
        let first:Node? = buildListFromArray([1])
        let second:Node? = buildListFromArray([3, 4, 5, 6])
        let result:Node? = shuffleMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 3, 4, 5, 6])))
    }
    
    func testShuffleMergeSecondListShorterThanTheOther() {
        let first:Node? = buildListFromArray([1, 8, 2, 1, 4, 2])
        let second:Node? = buildListFromArray([3])
        let result:Node? = shuffleMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 3, 8, 2, 1, 4, 2])))
    }
    
    func testShuffleMergeTwoLargeLists() {
        let first:Node? = buildListFromArray([9, 4, 2, 1, 3, 5, 6, 8, 7])
        let second:Node? = buildListFromArray([0xb, 0xc, 0x1, 0x3, 0x4, 0b1111, 0o7])
        let result:Node? = shuffleMerge(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([
            9, 0xb, 4, 0xc, 2, 0x1, 1, 0x3, 3, 0x4, 5, 0b1111, 6, 0o7, 8, 7])))
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
