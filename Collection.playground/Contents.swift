//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var array = [1,2,3,4]
var dict = ["a": 1, "b": 2, "c": 3]

extension Sequence where Element == Int {
    var sum: Int {
        return reduce(0, +)
    }
}

array.sum


