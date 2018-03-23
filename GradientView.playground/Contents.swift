import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    var gradient: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
}

let gradientView = GradientView()
gradientView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
gradientView.gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
gradientView.gradient.startPoint = CGPoint(x: 0, y: 0)
gradientView.gradient.endPoint = CGPoint(x: 1, y: 1)

PlaygroundPage.current.liveView = gradientView
