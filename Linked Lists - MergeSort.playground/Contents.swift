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

//from Codewars, sortedMerge works than in "sortedMerge"-exercise
func mergeSort(_ list:Node?) -> Node? {
    guard let _ = list, let _ = list!.next else {
        return list
    }
    var left: Node?, right: Node?
    try! frontBackSplit(source: list, front: &left, back: &right)
    return sortedMerge(first: mergeSort(left), second: mergeSort(right))
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

func sortedMerge(first:Node?, second:Node?) -> Node? {
    return insertSort(head: append(first, second))
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

enum frontBackSplitError: Error {
    case sourceListIsEmptyOrASingleNode
}

func frontBackSplit(source: Node?, front: inout Node?, back: inout Node?) throws {
    guard source?.next != nil else {throw frontBackSplitError.sourceListIsEmptyOrASingleNode}
    front = buildListFromArray(Array(NodeToArray(source)![0 ..< Int(Double(NodeToArray(source)!.count) / 2.0 + 0.5)]))
    back = buildListFromArray(Array(NodeToArray(source)![Int(Double(NodeToArray(source)!.count) / 2.0 + 0.5) ..< NodeToArray(source)!.count]))
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
        ("testMergeSortWithEmptyList", testMergeSortWithEmptyList),
        ("testMergeSortWithOneItem", testMergeSortWithOneItem),
        ("testMergeSortWithTwoItems", testMergeSortWithTwoItems),
        ("testMergeSortWithThreeItems", testMergeSortWithThreeItems),
        ("testMergeSortWithFourItems", testMergeSortWithFourItems),
        ("testMergeSortWithSixItems", testMergeSortWithSixItems),
        ("testMergeSortWithSeveralItems", testMergeSortWithSeveralItems),
        ]
    
    func testMergeSortWithEmptyList() {
        var list:Node? = nil
        list = mergeSort(list)
        XCTAssertNil(list)
    }
    
    func testMergeSortWithOneItem() {
        var list:Node? = buildListFromArray([4])
        list = mergeSort(list)
        XCTAssertTrue(linkedListsEqual(first: list, second: buildListFromArray([4])))
    }
    
    func testMergeSortWithTwoItems() {
        var list:Node? = buildListFromArray([4, 3])
        list = mergeSort(list)
        XCTAssertTrue(linkedListsEqual(first: list, second: buildListFromArray([3, 4])))
    }
    
    func testMergeSortWithThreeItems() {
        var list:Node? = buildListFromArray([9, 2, 4])
        list = mergeSort(list)
        XCTAssertTrue(linkedListsEqual(first: list, second: buildListFromArray([2, 4, 9])))
    }
    
    func testMergeSortWithFourItems() {
        var list:Node? = buildListFromArray([10, 3, 6, 2])
        list = mergeSort(list)
        XCTAssertTrue(linkedListsEqual(first: list, second: buildListFromArray([2, 3, 6, 10])))
    }
    
    func testMergeSortWithSixItems() {
        var list:Node? = buildListFromArray([4, 3, 8, 9, 1, 2])
        list = mergeSort(list)
        XCTAssertTrue(linkedListsEqual(first: list, second: buildListFromArray([1, 2, 3, 4, 8, 9])))
    }
    
    func testMergeSortWithSeveralItems() {
        var list:Node? = buildListFromArray([0, 4, -1, 4, 3, 74, 34, 22, 8, 90, 23])
        list = mergeSort(list)
        XCTAssertTrue(linkedListsEqual(first: list, second: buildListFromArray([
            -1, 0, 3, 4, 4, 8, 22, 23, 34, 74, 90]))
        )
    }
}
TestRunner().runTests(testClass: SolutionTest.self)