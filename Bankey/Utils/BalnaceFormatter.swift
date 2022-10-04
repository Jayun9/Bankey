//
//  BalnaceFormatter.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/30.
//
import Foundation
import UIKit

class BalanceFormatter {
    func makeFormateBalnace(balnce: Decimal) -> NSAttributedString {
        let moneyTuple = modf(balnce.doubleValue)
        
        let dallar = convertDallar(moneyTuple.0)
        let cent = convertCents(moneyTuple.1)
        
        return makeFormateBalnace(dallar: dallar, cent: cent)
    }
    
    private func convertDallar(_ dallars: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        if let formatResult = formatter.string(from: dallars as NSNumber) {
            var dallar = formatResult.split(separator: ".")[0]
            dallar.removeFirst()
            return String(dallar)
        }
        return ""
    }
    
    private func convertCents(_ cents: Double) -> String{
        var convertCent = "00"
        if cents != 0 {
           convertCent = String(format: "%.0f", cents * 100)
        }
        return convertCent
    }
    
    func makeFormateBalnace(dallar: String, cent: String) -> NSAttributedString {
        let signAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .caption1), .baselineOffset: 8]
        let dallarAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: signAttribute)
        let dallarString = NSAttributedString(string: dallar, attributes: dallarAttribute)
        let centString = NSAttributedString(string: cent, attributes: centAttribute)
        
        rootString.append(dallarString)
        rootString.append(centString)
        
        return rootString
    }
}

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
