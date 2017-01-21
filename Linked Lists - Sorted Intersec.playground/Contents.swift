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

func SortedIntersect(first:Node?, second:Node?) -> Node? {
    
    guard first != nil && second != nil else {return nil}
    
    var first = first
    var second = second
    
    while ((first?.data)! < (second?.data)! || (first?.data) == (first?.next?.data)) && first?.next != nil {first = first?.next}
    while ((second?.data)! < (first?.data)! || (second?.data) == (second?.next?.data)) && second?.next != nil  {second = second?.next}
    
    guard first?.data == second?.data else {return nil}
    
    first?.next = SortedIntersect(first: first?.next, second: second?.next)
    
    return first
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
        ("testSortedIntersectWithEmptyLists", testSortedIntersectWithEmptyLists),
        ("testSortedIntersectFirstListNil", testSortedIntersectFirstListNil),
        ("testSortedIntersectSecondListNil", testSortedIntersectSecondListNil),
        ("testSortedIntersect", testSortedIntersect),
        ("testSortedIntersectAllDuplicates", testSortedIntersectAllDuplicates),
        ("testSortedIntersectSeveralDuplicates", testSortedIntersectSeveralDuplicates),
        ]
    
    func testSortedIntersectWithEmptyLists() {
        let first:Node? = nil
        let second:Node? = nil
        let result:Node? = SortedIntersect(first: first, second: second)
        XCTAssertNil(result)
    }
    
    func testSortedIntersectFirstListNil() {
        let first:Node? = nil
        let second:Node? = buildListFromArray([1, 4, 6, 7, 8])
        let result:Node? = SortedIntersect(first: first, second: second)
        XCTAssertNil(result)
    }
    
    func testSortedIntersectSecondListNil() {
        let first:Node? = buildListFromArray([1, 4, 6, 7, 8])
        let second:Node? = nil
        let result:Node? = SortedIntersect(first: first, second: second)
        XCTAssertNil(result)
    }
    
    func testSortedIntersect() {
        let first:Node? = buildListFromArray([1, 2, 2, 3, 3, 6])
        let second:Node? = buildListFromArray([1, 3, 4, 5, 6])
        let result:Node? = SortedIntersect(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([1, 3, 6])))
    }
    
    func testSortedIntersectAllDuplicates() {
        let first:Node? = buildListFromArray([2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2])
        let second:Node? = buildListFromArray([2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2])
        let result:Node? = SortedIntersect(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([2])))
    }
    
    func testSortedIntersectSeveralDuplicates() {
        let first:Node? = buildListFromArray([2, 2, 3, 3, 4, 4, 4, 5])
        let second:Node? = buildListFromArray([1, 1, 2, 2, 2, 2, 4, 5])
        let result:Node? = SortedIntersect(first: first, second: second)
        XCTAssertTrue(linkedListsEqual(first: result, second: buildListFromArray([2, 4, 5])))
    }
}

TestRunner().runTests(testClass: SolutionTest.self)