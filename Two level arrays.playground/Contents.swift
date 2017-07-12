//: Playground - noun: a place where people can play

import UIKit

func flattenTwoLevels(_ arr:[Any]) -> [Any] {
    var array: [Any] = []
    for element in arr {
        if let ele = element as? [Any] {
            array.append(flattenTwoLevelsHelper(ele))
        } else {
            array.append(element)
        }
    }
    return array
}

func flattenTwoLevelsHelper(_ arr:[Any]) -> [Any] {
    var array: [Any] = []
    for element in arr {
        if let ele = element as? [Any] {
            array += flattenTwoLevelsHelper(ele)
        } else {
            array += [element]
        }
    }
    return array
}
