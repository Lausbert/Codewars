//: Playground - noun: a place where people can play

import UIKit

func sortTwisted37(_ arr: [Int]) -> [Int] {
    let arrStr = arr.map {String($0)}
    let arrStrModified = arrStr.map {$0.replacingOccurrences(of: "3", with: "x").replacingOccurrences(of: "7", with: "3").replacingOccurrences(of: "x", with: "7")}
    let arrIntModified = arrStrModified.flatMap {Int($0)}
    let arrIntModifiedSorted = arrIntModified.sorted(by: {$0 < $1})
    let arrStrModifiedSorted = arrIntModifiedSorted.map {String($0)}
    let arrStrSorted = arrStrModifiedSorted.map {$0.replacingOccurrences(of: "3", with: "x").replacingOccurrences(of: "7", with: "3").replacingOccurrences(of: "x", with: "7")}
    let arrIntSorted = arrStrSorted.flatMap {Int($0)}
    return arrIntSorted
}
