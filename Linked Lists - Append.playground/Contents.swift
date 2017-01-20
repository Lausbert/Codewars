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
        ("testAppend", testAppend),
        ("testAppendFirstListIsNil", testAppendFirstListIsNil),
        ("testAppendSecondListIsNil", testAppendSecondListIsNil),
        ("testAppendBothListsAreNil", testAppendBothListsAreNil),
        ]
    
    func testAppend() {
        let first:Node? = buildOneTwoThree()
        let second:Node? = buildOneTwoThree()
        var result:Node?
        result = append(first, second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 2, 3, 1, 2, 3])))
    }
    
    func testAppendFirstListIsNil() {
        let first:Node? = nil
        let second:Node? = buildOneTwoThree()
        var result:Node?
        result = append(first, second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 2, 3])))
    }
    
    func testAppendSecondListIsNil() {
        let first:Node? = buildOneTwoThree()
        let second:Node? = nil
        var result:Node?
        result = append(first, second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 2, 3])))
    }
    
    func testAppendBothListsAreNil() {
        let first:Node? = nil
        let second:Node? = nil
        var result:Node?
        result = append(first, second)
        XCTAssertTrue(linkedListsEqual(first: result, second: nil))
    }
}

TestRunner().runTests(testClass: SolutionTest.self)