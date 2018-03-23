import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

protocol GradientRepresenting {
    var colors: [UIColor] { get }
    var startPoint: CGPoint { get }
    var endPoint: CGPoint { get }
}

class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    var gradient: GradientRepresenting? {
        didSet {
            gradientLayer.colors = gradient?.colors.map { $0.cgColor }
            gradientLayer.startPoint = gradient?.startPoint ?? CGPoint.zero
            gradientLayer.endPoint = gradient?.endPoint ?? CGPoint.zero
        }
    }
}

let gradientView = GradientView()
gradientView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

struct Gradient: GradientRepresenting {
    var colors: [UIColor]
    var startPoint: CGPoint
    var endPoint: CGPoint
}

gradientView.gradient = Gradient(colors: [UIColor.orange, UIColor.yellow],
                                 startPoint: CGPoint.zero,
                                 endPoint: CGPoint(x: 1, y: 1))

PlaygroundPage.current.liveView = gradientView
