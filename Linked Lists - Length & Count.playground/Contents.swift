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

func length(_ head: Node?) -> Int {
    guard let node = head else {
        return 0
    }
    return length(node.next) + 1
}

func count(_ head: Node?, _ data: Int) -> Int {
    guard let node = head else {
        return 0
    }
    return count(node.next, data) + (node.data == data ? 1 : 0)
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
        ("testLength", testLength),
        ("testCountWithNil", testCountWithNil),
        ("testCountWith3ItemList", testCountWith3ItemList),
        ("testCountWithLargeList", testCountWithLargeList),
        ]
    
    let list:Node? = buildOneTwoThree()
    let largeList:Node? = buildListFromArray([8, 4, 1, 2, 9, 4, 2, 8, 2])
    
    func testLength() {
        XCTAssertEqual(length(nil), 0)
        XCTAssertEqual(length(Node(1)), 1)
        XCTAssertEqual(length(list), 3)
        XCTAssertEqual(length(largeList), 9)
    }
    
    func testCountWithNil() {
        XCTAssertEqual(count(nil, 1), 0)
    }
    
    func testCountWith3ItemList() {
        XCTAssertEqual(count(list, 1), 1)
        XCTAssertEqual(count(list, 2), 1)
        XCTAssertEqual(count(list, 3), 1)
    }
    
    func testCountWithLargeList() {
        XCTAssertEqual(count(largeList, 1), 1)
        XCTAssertEqual(count(largeList, 2), 3)
        XCTAssertEqual(count(largeList, 3), 0)
        XCTAssertEqual(count(largeList, 4), 2)
        XCTAssertEqual(count(largeList, 5), 0)
        XCTAssertEqual(count(largeList, 8), 2)
        XCTAssertEqual(count(largeList, 9), 1)
    }
}

TestRunner().runTests(testClass: SolutionTest.self)


