//
//  YRedefine.swift
//  BarChartSample
//
//  Created by IOS-Sun on 16/6/1.
//  Copyright © 2016年 IOS-Sun. All rights reserved.
//

import Foundation

extension ChartYAxisRenderer
{
    //TODO:当数值大于万位，省略后边位数
    public func getBackNewTextFromYpiex(text text: String) -> String
    {
        
        let startWord: Character = text[text.startIndex]
        
        var newText: String = text
        newText = newText.stringByReplacingOccurrencesOfString(",", withString: "")
        newText = newText.stringByReplacingOccurrencesOfString("-", withString: "")

        let len = newText.characters.count;
        
        if newText == "0" {
            return newText
        }
        
        if len < 2 {
            return newText
        }
        
        switch len {
        case 2:
            let rRang = newText.endIndex.advancedBy(-1)..<newText.endIndex
            newText.removeRange(rRang)
            newText = "0.00" + newText
        case 3:
            let rRang = newText.endIndex.advancedBy(-2)..<newText.endIndex
            newText.removeRange(rRang)
            newText = "0.0" + newText
        case 4:
            let rRang = newText.endIndex.advancedBy(-3)..<newText.endIndex
            newText.removeRange(rRang)
            newText = "0." + newText
        default:
            let rRang = newText.endIndex.advancedBy(-3)..<newText.endIndex
            newText.removeRange(rRang)
            
            let lRange = newText.endIndex.advancedBy(-1)..<newText.endIndex
            let lastWord : String = newText[lRange]
            newText.removeRange(lRange)
            
            newText = newText + "." + lastWord
        }
        
        if startWord == "-" {
            newText = "-" + newText
        }
        
        return newText
    }
}