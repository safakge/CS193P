//
//  CardShape.swift
//  SetGame
//
//  Created by Safak Gezer on 12/8/20.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


extension CGImage {
    static var sharedContext: CIContext?
    static var sharedFilter = CIFilter.stripesGenerator()
    
    static func stripes(colors: (UIColor, UIColor)) -> CGImage {
        if sharedContext == nil {
            sharedContext = CIContext()
            sharedFilter = CIFilter.stripesGenerator()
        }
        
        let width: CGFloat = 100
        let ratio: CGFloat = 0.25
        
        let filter = sharedFilter
        filter.color0 = CIColor(color: colors.0)
        filter.color1 = CIColor(color: colors.1)
        filter.width = Float(width * ratio)
        filter.center = CGPoint(x: CGFloat(filter.width), y: 0)
        let size = CGSize(width: width, height: width)
        let bounds = CGRect(origin: .zero, size: size)
        
        let stripesOutput = filter.outputImage!
        return sharedContext!.createCGImage(stripesOutput, from: bounds)!
    }
}


struct CardShape: Shape {
    var shapeType:SetGame.Card.CardFeatureShapeType
    var strokeWidth: CGFloat = 3.0
    
    func applySetShapeFeatures(forCard card: SetGame.Card) -> some View {
        var view:AnyView
        let cardColor = ShapedSetGame.shapeColor(forFeatureValue: card.color)
        switch card.shading {
            case .One:
                view = AnyView(self.stroke(lineWidth: strokeWidth))
            case .Two:
                view = AnyView(self.fill(CardShape.stripedImagePaint(forColor: UIColor(cardColor))))
            case .Three:
                view = AnyView(self.fill())
        }
        
        view = AnyView(view.foregroundColor(cardColor))
        
        return view
    }
    
    static var _stripedImagePaintCache:[UIColor:ImagePaint] = [:]
    static func stripedImagePaint(forColor color: UIColor) -> ImagePaint {
        if let cached = _stripedImagePaintCache[color] {
            return cached
        } else {
            let imagePaint = ImagePaint(image: Image(decorative: CGImage.stripes(colors: (color, .clear)), scale: 10))
            _stripedImagePaintCache[color] = imagePaint
            return imagePaint
        }
    }
    
    func path(in rect: CGRect) -> Path {
        switch shapeType {
            case .One:
                return diamondPath(in: rect)
            case .Two:
                return ovalPath(in: rect)
            case .Three:
                return squigglePath(in: rect)
        }
    }
    
    func squigglePath(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 104.0, y: 15.0))
        path.addCurve(to: CGPoint(x: 63.0, y: 54.0),
                      control1: CGPoint(x: 112.4, y: 36.9),
                      control2: CGPoint(x: 89.7, y: 60.8))
        path.addCurve(to: CGPoint(x: 27.0, y: 53.0),
                      control1: CGPoint(x: 52.3, y: 51.3),
                      control2: CGPoint(x: 42.2, y: 42.0))
        path.addCurve(to: CGPoint(x: 5.0, y: 40.0),
                      control1: CGPoint(x: 9.6, y: 65.6),
                      control2: CGPoint(x: 5.4, y: 58.3))
        path.addCurve(to: CGPoint(x: 36.0, y: 12.0),
                      control1: CGPoint(x: 4.6, y: 22.0),
                      control2: CGPoint(x: 19.1, y: 9.7))
        path.addCurve(to: CGPoint(x: 89.0, y: 14.0),
                      control1: CGPoint(x: 59.2, y: 15.2),
                      control2: CGPoint(x: 61.9, y: 31.5))
        path.addCurve(to: CGPoint(x: 104.0, y: 15.0),
                      control1: CGPoint(x: 95.3, y: 10.0),
                      control2: CGPoint(x: 100.9, y: 6.9))
        
        let pathRect = path.boundingRect
        path = path.offsetBy(dx: rect.minX - pathRect.minX, dy: rect.minY - pathRect.minY)
        
        let scale: CGFloat = rect.width / pathRect.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        path = path.applying(transform)
        
        
        return path
            .offsetBy(dx: rect.minX - path.boundingRect.minX, dy: rect.midY - path.boundingRect.midY)
    }
    
    func diamondPath(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX + 1, y: rect.minY))
        
        return path
    }
    
    func ovalPath(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        
        return path
    }
}
