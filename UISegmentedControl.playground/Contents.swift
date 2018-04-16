import UIKit
import PlaygroundSupport

extension UISegmentedControl {
    
    enum Item {
        case text(String)
        case image(UIImage)
        
        var value: Any {
            switch self {
            case .text(let val): return val
            case .image(let val): return val
            }
        }
    }
    
    convenience init(items: [Item]) {
        self.init(items: items.map { $0.value })
    }
    
    var items: [Item] {
        set {
            removeAllSegments()
            for (index, item) in newValue.enumerated() {
                insert(item: item, at: index)
            }
        }
        get {
            let range = 0..<numberOfSegments
            return range.compactMap { item(at: $0) }
        }
    }
    
    private func insert(item: Item, at index: Int) {
        switch item {
        case .text(let value):
            insertSegment(withTitle: value, at: index, animated: false)
        case .image(let value):
            insertSegment(with: value, at: index, animated: false)
        }
    }
    
    private func item(at index: Int) -> Item? {
        if let title = titleForSegment(at: index) {
            return Item.text(title)
        } else if let image = imageForSegment(at: index) {
            return Item.image(image)
        } else {
            return nil
        }
    }
}

let segmentedControl = UISegmentedControl(items: ["a"])
segmentedControl.items = [UISegmentedControl.Item.text("raz"),
                          UISegmentedControl.Item.text("dwa")]

let x = segmentedControl.items

PlaygroundPage.current.liveView = segmentedControl
