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
        ("Test Insert Node", testInsertNode),
        ("Test Build Linked List", testBuildLinkedList),
        ]
    
    func testInsertNode() {
        XCTAssertEqual(push(nil, 1).data, 1, "Should be able to create a new linked list with push().");
        XCTAssertNil(push(nil, 1).next, "Should be able to create a new linked list with push().");
        XCTAssertEqual(push(Node(1), 2).data, 2, "Should be able to prepend a node to an existing node.");
        XCTAssertEqual(push(Node(1), 2).next!.data, 1, "Should be able to prepend a node to an existing node.");
    }
    
    func testBuildLinkedList() {
        XCTAssertEqual(buildOneTwoThree().data, 1, "Value at index 0 should be 1.");
        XCTAssertEqual(buildOneTwoThree().next!.data, 2, "Value at index 1 should be 2.");
        XCTAssertEqual(buildOneTwoThree().next!.next!.data, 3, "Value at index 2 should be 3.");
        XCTAssertNil(buildOneTwoThree().next!.next!.next, "Value at index 3 should be null.");
    }
}

TestRunner().runTests(testClass: SolutionTest.self)
