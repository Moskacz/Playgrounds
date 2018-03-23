//: Playground - noun: a place where people can play

import UIKit

let cal = Calendar.current
cal.weekdaySymbols
cal.component(.weekOfYear, from: Date())
cal.component(.day, from: Date())
cal.component(.month, from: Date())
cal.component(.year, from: Date())
cal.ordinality(of: .month, in: .day, for: Date())
let components = cal.dateComponents([.day, .weekOfYear, .month, .year], from: Date().addingTimeInterval(1000000))
let era = cal.dateComponents([.era], from: Date())
let day = cal.ordinality(of: .day, in: .era, for: Date())!
let weekDay = cal.component(.weekday, from: Date())
let id: Calendar.Identifier = cal.identifier


class MyClass: CustomStringConvertible {
    var description: String {
        return "test"
    }
}

final class WeakBox<T:AnyObject>: CustomStringConvertible {
    
    public weak var boxed: T?
    
    public init(value: T) {
        boxed = value
    }
    
    var description: String {
        return "test"
    }
    
}

class WeakArray<T:AnyObject>{
    private let items: [WeakBox<T>]
    
    init(items: [T]) {
        self.items = items.map { WeakBox(value: $0) }
    }
}

extension WeakArray: Sequence {
    typealias Iterator = WeakArrayIterator<T>
    
    func makeIterator() -> WeakArrayIterator<T> {
        return WeakArrayIterator<T>(itemsIterator: items.makeIterator())
    }
}

struct WeakArrayIterator<T:AnyObject>: IteratorProtocol {
    
    typealias Element = T
    private var itemsIterator: IndexingIterator<[WeakBox<T>]>
    
    init(itemsIterator: IndexingIterator<[WeakBox<T>]>) {
        self.itemsIterator = itemsIterator
    }
    
    mutating func next() -> T? {
        return itemsIterator.next()?.boxed
        guard let nextItem = itemsIterator.next() else {
            return nil
        }
        
        
        
        if nextItem.boxed != nil {
            return nextItem.boxed
        } else {
            return next()
        }
    }
}

let array = WeakArray(items: [MyClass(), MyClass(), MyClass()])
for v in array {
    print(v)
}


