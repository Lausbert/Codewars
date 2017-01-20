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

enum getNthError: Error {
    case InvalidArgumentException
}

func getNth(_ head: Node?, _ index: Int) throws -> Node? {
    guard head != nil else {throw getNthError.InvalidArgumentException}
    if index == 0 {return head}
    return try getNth(head?.next, index-1)
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
        ("testNode", testNode),
        ]
    
    let list:Node? = buildOneTwoThree()
    let largeList:Node? = buildListFromArray([8, 4, 1, 2, 9, 4, 2, 8, 2])
    
    func testNode() {
        XCTAssertEqual(try! getNth(list, 0)?.data, 1)
        XCTAssertEqual(try! getNth(list, 1)?.data, 2)
        XCTAssertEqual(try! getNth(list, 2)?.data, 3)
        XCTAssertThrowsError(try getNth(list, 3))
        XCTAssertThrowsError(try getNth(list, 10))
        XCTAssertThrowsError(try getNth(list, -1))
    }
}

TestRunner().runTests(testClass: SolutionTest.self)




