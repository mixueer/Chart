//
//  BrokenLine.swift
//  BarChartSample
//
//  Created by IOS-Sun on 16/5/31.
//  Copyright © 2016年 IOS-Sun. All rights reserved.
//

import Foundation

extension BarChartRenderer
{
//    public override static func initialize() {
//        struct Static {
//            static var token: dispatch_once_t = 0;
//        }
//        
//        if self != BarChartRenderer.self {
//            return
//        }
//        
//        dispatch_once(&Static.token) {
//            let originalSelector = Selector("drawBrokenLine")
//            let swizzledSelector = Selector("drawBrokenLineTwo")
//            //#selector(BarChartRenderer.drawBrokenLine(context:indices:))
//            
//            let originalMethod = class_getInstanceMethod(self, originalSelector)
//            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
//            
//            let didAddMethod:Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//            
//            if didAddMethod {
//                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//            }else {
//                method_exchangeImplementations(originalMethod, swizzledMethod)
//            }
//        }
//    }
    

    func drawBrokenLine(context: CGContext, dataProvider: BarChartDataProvider,set: IBarChartDataSet, barData: BarChartData, index: Int, y1: Double, y2: Double, x: CGFloat) {

        //TODO: 构建柱子中间的虚线，默认情况下显示虚线
        var _highlightPointBuffer = CGPoint()
        
        CGContextSetStrokeColorWithColor(context, set.highlightColor.CGColor)
        let width : Double = barData.xValAverageLength
        CGContextSetLineWidth(context, set.highlightLineWidth)
        
        if (set.highlightLineDashLengths != nil)
        {
            CGContextSetLineDash(context, set.highlightLineDashPhase, set.highlightLineDashLengths!, set.highlightLineDashLengths!.count)
        }
        else
        {
            CGContextSetLineDash(context, 0.0, [12.0, 10.0], 3)
        }
        
        let yValue = set.yValForXIndex(index)
//        if yValue.isNaN {
//            continue
//        }
        
        if y1 >= -y2 {
            _highlightPointBuffer.x = CGFloat(x)
            _highlightPointBuffer.y = 0
            
            let trans = dataProvider.getTransformer(set.axisDependency)
            
            trans.pointValueToPixel(&_highlightPointBuffer)
            
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, _highlightPointBuffer.x, 0)
            CGContextAddLineToPoint(context, _highlightPointBuffer.x, _highlightPointBuffer.y)
            CGContextStrokePath(context)
        } else {
            _highlightPointBuffer.x = CGFloat(x)
            _highlightPointBuffer.y = 0
            
            let trans = dataProvider.getTransformer(set.axisDependency)
            
            trans.pointValueToPixel(&_highlightPointBuffer)
            
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, _highlightPointBuffer.x, viewPortHandler.contentBottom)
            CGContextAddLineToPoint(context, _highlightPointBuffer.x, _highlightPointBuffer.y)
            CGContextStrokePath(context)
        }
    }
    
}
