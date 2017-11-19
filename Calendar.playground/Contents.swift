//: Playground - noun: a place where people can play

import UIKit

let cal = Calendar.current
cal.weekdaySymbols
cal.component(.weekOfYear, from: Date())
cal.component(.day, from: Date())
cal.component(.month, from: Date())
cal.component(.year, from: Date())
let components = cal.dateComponents([.day, .weekOfYear, .month, .year], from: Date())
