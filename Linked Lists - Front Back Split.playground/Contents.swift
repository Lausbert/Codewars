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

enum frontBackSplitError: Error {
    case sourceListIsEmptyOrASingleNode
}

func frontBackSplit(source: Node?, front: inout Node?, back: inout Node?) throws {
    guard source?.next != nil else {throw frontBackSplitError.sourceListIsEmptyOrASingleNode}
    front = buildListFromArray(Array(NodeToArray(source)![0 ..< Int(Double(NodeToArray(source)!.count) / 2.0 + 0.5)]))
    back = buildListFromArray(Array(NodeToArray(source)![Int(Double(NodeToArray(source)!.count) / 2.0 + 0.5) ..< NodeToArray(source)!.count]))
}

func NodeToArray(_ head:Node?) -> [Int]? {
    guard head?.next != nil else {return [(head?.data)!]}
    var array: [Int] = NodeToArray(head?.next)!
    array.insert((head?.data)!, at: 0)
    return array
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
        ("testFrontBackSplitEmptyList", testFrontBackSplitEmptyList),
        ("testFrontBackSplitOneItemList", testFrontBackSplitOneItemList),
        ("testFrontBackSplitTwoItemList", testFrontBackSplitTwoItemList),
        ("testFrontBackSplitThreeItemList", testFrontBackSplitThreeItemList),
        ("testFrontBackSplitFourItemList", testFrontBackSplitFourItemList),
        ("testFrontBackSplitFiveItemList", testFrontBackSplitFiveItemList),
        ("testFrontBackSplitSixItemList", testFrontBackSplitSixItemList),
        ("testFrontBackSplitSevenItemList", testFrontBackSplitSevenItemList),
        ("testFrontBackSplitEightItemList", testFrontBackSplitEightItemList),
        
        ]
    
    func testFrontBackSplitEmptyList() {
        let source:Node? = nil
        var front:Node? = nil
        var back:Node? = nil
        XCTAssertThrowsError(try frontBackSplit(source: source, front: &front, back: &back))
    }
    
    func testFrontBackSplitOneItemList() {
        let source:Node? = buildListFromArray([1])
        var front:Node? = nil
        var back:Node? = nil
        XCTAssertThrowsError(try frontBackSplit(source: source, front: &front, back: &back))
    }
    
    func testFrontBackSplitTwoItemList() {
        let source:Node? = buildListFromArray([1, 2])
        var front:Node? = nil
        var back:Node? = nil
        try! frontBackSplit(source: source, front: &front, back: &back)
        XCTAssertTrue(linkedListsEqual(first: front, second: buildListFromArray([1])))
        XCTAssertTrue(linkedListsEqual(first: back, second: buildListFromArray([2])))
    }
    
    func testFrontBackSplitThreeItemList() {
        let source:Node? = buildListFromArray([1, 2, 3])
        var front:Node? = nil
        var back:Node? = nil
        try! frontBackSplit(source: source, front: &front, back: &back)
        XCTAssertTrue(linkedListsEqual(first: front, second: buildListFromArray([1, 2])))
        XCTAssertTrue(linkedListsEqual(first: back, second: buildListFromArray([3])))
    }
    
    func testFrontBackSplitFourItemList() {
        let source:Node? = buildListFromArray([1, 2, 3, 4])
        var front:Node? = nil
        var back:Node? = nil
        try! frontBackSplit(source: source, front: &front, back: &back)
        XCTAssertTrue(linkedListsEqual(first: front, second: buildListFromArray([1, 2])))
        XCTAssertTrue(linkedListsEqual(first: back, second: buildListFromArray([3, 4])))
    }
    
    func testFrontBackSplitFiveItemList() {
        let source:Node? = buildListFromArray([1, 2, 3, 4, 5])
        var front:Node? = nil
        var back:Node? = nil
        try! frontBackSplit(source: source, front: &front, back: &back)
        XCTAssertTrue(linkedListsEqual(first: front, second: buildListFromArray([1, 2, 3])))
        XCTAssertTrue(linkedListsEqual(first: back, second: buildListFromArray([4, 5])))
    }
    
    func testFrontBackSplitSixItemList() {
        let source:Node? = buildListFromArray([1, 2, 3, 4, 5, 6])
        var front:Node? = nil
        var back:Node? = nil
        try! frontBackSplit(source: source, front: &front, back: &back)
        XCTAssertTrue(linkedListsEqual(first: front, second: buildListFromArray([1, 2, 3])))
        XCTAssertTrue(linkedListsEqual(first: back, second: buildListFromArray([4, 5, 6])))
    }
    
    func testFrontBackSplitSevenItemList() {
        let source:Node? = buildListFromArray([1, 2, 3, 4, 5, 6, 7])
        var front:Node? = nil
        var back:Node? = nil
        try! frontBackSplit(source: source, front: &front, back: &back)
        XCTAssertTrue(linkedListsEqual(first: front, second: buildListFromArray([1, 2, 3, 4])))
        XCTAssertTrue(linkedListsEqual(first: back, second: buildListFromArray([5, 6, 7])))
    }
    
    func testFrontBackSplitEightItemList() {
        let source:Node? = buildListFromArray([1, 2, 3, 4, 5, 6, 7, 8])
        var front:Node? = nil
        var back:Node? = nil
        try! frontBackSplit(source: source, front: &front, back: &back)
        XCTAssertTrue(linkedListsEqual(first: front, second: buildListFromArray([1, 2, 3, 4])))
        XCTAssertTrue(linkedListsEqual(first: back, second: buildListFromArray([5, 6, 7, 8])))
    }
    
}

TestRunner().runTests(testClass: SolutionTest.self)



