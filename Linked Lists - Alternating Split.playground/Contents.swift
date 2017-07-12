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

enum alternatingSplitError: Error {
    case listIsEmptyOrContainsJustASingleNode
}

struct Context {
    var source:Node?
    var dest:Node?
}

func alternatingSplit(head:Node?) throws -> Context? {
    guard head != nil && head?.next != nil else {throw alternatingSplitError.listIsEmptyOrContainsJustASingleNode}
    var list = NodeToArray(head)![0...((NodeToArray(head)?.count)!-1)]
    var list1: [Int] = []
    var list2: [Int] = []
    while list != [] {
        list1.append(list.popFirst()!)
        if list != [] {
            list2.append(list.popFirst()!)
        }
    }
    return Context(source: buildListFromArray(list1), dest: buildListFromArray(list2))
}

func NodeToArray(_ head:Node?) -> [Int]? {
    guard head?.next != nil else {return [(head?.data)!]}
    var array: [Int] = NodeToArray(head?.next)!
    array.insert((head?.data)!, at: 0)
    return array
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
    public init() {}
    
    public func runTests(testClass:AnyClass) {
        let tests = testClass as! XCTestCase.Type
        let testSuite = tests.defaultTestSuite()
        testSuite.run()
        _ = testSuite.testRun as! XCTestSuiteRun
    }
    
}

class SolutionTest: XCTestCase {
    static var allTests = [
        ("testAlternatingSplitWithEmptyList", testAlternatingSplitWithEmptyList),
        ("testAlternatingSplitWithOneItemList", testAlternatingSplitWithOneItemList),
        ("testAlternatingSplitWithTwoItemList", testAlternatingSplitWithTwoItemList),
        ("testAlternatingSplitWithSmallEvenList", testAlternatingSplitWithSmallEvenList),
        ("testAlternatingSplitWithSmallOddList", testAlternatingSplitWithSmallOddList),
        ("testAlternatingSplitWithEvenList", testAlternatingSplitWithEvenList),
        ("testAlternatingSplitWithOddList", testAlternatingSplitWithOddList),
        ("testAlternatingSplitWithLargeEvenList", testAlternatingSplitWithLargeEvenList),
        ("testAlternatingSplitWithLargeOddList", testAlternatingSplitWithLargeOddList),
        ]
    
    func testAlternatingSplitWithEmptyList() {
        XCTAssertThrowsError(try alternatingSplit(head: nil))
    }
    
    func testAlternatingSplitWithOneItemList() {
        let theList:Node? = buildListFromArray([1])
        XCTAssertThrowsError(try alternatingSplit(head: theList))
    }
    
    func testAlternatingSplitWithTwoItemList() {
        let theList:Node? = buildListFromArray([1, 2])
        let source = try! alternatingSplit(head: theList)?.source
        let dest = try! alternatingSplit(head: theList)?.dest
        XCTAssertTrue(linkedListsEqual(first: source, second: buildListFromArray([1])))
        XCTAssertTrue(linkedListsEqual(first: dest, second: buildListFromArray([2])))
    }
    
    func testAlternatingSplitWithSmallEvenList() {
        let theList:Node? = buildListFromArray([1, 2, 3, 4])
        let source = try! alternatingSplit(head: theList)?.source
        let dest = try! alternatingSplit(head: theList)?.dest
        XCTAssertTrue(linkedListsEqual(first: source, second: buildListFromArray([1, 3])))
        XCTAssertTrue(linkedListsEqual(first: dest, second: buildListFromArray([2, 4])))
    }
    
    func testAlternatingSplitWithSmallOddList() {
        let theList:Node? = buildListFromArray([1, 2, 3])
        let source = try! alternatingSplit(head: theList)?.source
        let dest = try! alternatingSplit(head: theList)?.dest
        XCTAssertTrue(linkedListsEqual(first: source, second: buildListFromArray([1, 3])))
        XCTAssertTrue(linkedListsEqual(first: dest, second: buildListFromArray([2])))
    }
    
    func testAlternatingSplitWithEvenList() {
        let theList:Node? = buildListFromArray([1, 2, 3, 4, 5, 6])
        let source = try! alternatingSplit(head: theList)?.source
        let dest = try! alternatingSplit(head: theList)?.dest
        XCTAssertTrue(linkedListsEqual(first: source, second: buildListFromArray([1, 3, 5])))
        XCTAssertTrue(linkedListsEqual(first: dest, second: buildListFromArray([2, 4, 6])))
    }
    
    func testAlternatingSplitWithOddList() {
        let theList:Node? = buildListFromArray([1, 2, 3, 4, 5, 6, 7])
        let source = try! alternatingSplit(head: theList)?.source
        let dest = try! alternatingSplit(head: theList)?.dest
        XCTAssertTrue(linkedListsEqual(first: source, second: buildListFromArray([1, 3, 5, 7])))
        XCTAssertTrue(linkedListsEqual(first: dest, second: buildListFromArray([2, 4, 6])))
    }
    
    func testAlternatingSplitWithLargeEvenList() {
        let theList:Node? = buildListFromArray([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
        let source = try! alternatingSplit(head: theList)?.source
        let dest = try! alternatingSplit(head: theList)?.dest
        XCTAssertTrue(linkedListsEqual(first: source, second: buildListFromArray([1, 3, 5, 7, 9, 11])))
        XCTAssertTrue(linkedListsEqual(first: dest, second: buildListFromArray([2, 4, 6, 8, 10, 12])))
    }
    
    func testAlternatingSplitWithLargeOddList() {
        let theList:Node? = buildListFromArray([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])
        let source = try! alternatingSplit(head: theList)?.source
        let dest = try! alternatingSplit(head: theList)?.dest
        XCTAssertTrue(linkedListsEqual(first: source, second: buildListFromArray([1, 3, 5, 7, 9, 11, 13])))
        XCTAssertTrue(linkedListsEqual(first: dest, second: buildListFromArray([2, 4, 6, 8, 10, 12])))
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
