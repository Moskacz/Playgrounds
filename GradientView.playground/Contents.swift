import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension CGPoint {
    
    public class Cubic {
        var topLeft: CGPoint { return CGPoint(x: 0, y: 0) }
        var topRight: CGPoint { return CGPoint(x: 1, y: 0) }
        var bottomLeft: CGPoint { return CGPoint(x: 0, y: 1) }
        var bottomRight: CGPoint { return CGPoint(x: 1, y: 1) }
    }
    
    public static let cubic = Cubic()
}

public struct GradientPoints {
    public var startPoint: CGPoint
    public var endPoint: CGPoint
}

public enum GradientDirection {
    case vertical
    case horizontal
    case skewRight
    case skewLeft
    
    public var points: GradientPoints {
        switch self {
        case .vertical:
            return GradientPoints(startPoint: CGPoint.cubic.topLeft, endPoint: CGPoint.cubic.bottomLeft)
        case .horizontal:
            return GradientPoints(startPoint: CGPoint.cubic.topLeft, endPoint: CGPoint.cubic.topRight)
        case .skewRight:
            return GradientPoints(startPoint: CGPoint.cubic.topLeft, endPoint: CGPoint.cubic.bottomRight)
        case .skewLeft:
            return GradientPoints(startPoint: CGPoint.cubic.topRight, endPoint: CGPoint.cubic.bottomLeft)
        }
    }
}

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
    
    init(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    init(colors: [UIColor], direction: GradientDirection) {
        let points = direction.points
        self.init(colors: colors, startPoint: points.startPoint, endPoint: points.endPoint)
    }
}

let gradient = Gradient(colors: [#colorLiteral(red: 1, green: 0.5739069632, blue: 0.3785911202, alpha: 1), #colorLiteral(red: 1, green: 0.8280364275, blue: 0.2038422363, alpha: 1), #colorLiteral(red: 1, green: 0.5739069632, blue: 0.3785911202, alpha: 1)],
                        direction: .vertical)
gradientView.gradient = gradient

class GradientButton: UIButton {
    
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
            gradientLayer.locations = [0.0, 0.5, 1]
        }
    }
    
}

let button = GradientButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
button.gradient = gradient
button.setTitle("+", for: .normal)
button.layer.cornerRadius = 50

PlaygroundPage.current.liveView = button
