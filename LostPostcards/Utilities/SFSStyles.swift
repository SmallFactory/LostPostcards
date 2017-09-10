//
//  SFSStyles.swift
//  LostPostcards
//
//  Created by Small Factory Studios on 9/8/17.
//  Copyright © 2017 Small Factory Studios. All rights reserved.
//

import UIKit
import SwiftHEXColors

public class SFSStyles {
    
    // MARK: Colors
    public enum color: Int {
        case anakiwa
        case balticSea
        case black
        case capePalliser
        case conch
        case edgewater
        case greenWhite
        case hillary
        case mondo
        case pewter
        case satinLinen
        case submarine
        case transparent
        case tuatara
        case tumbleweed
        case white
        case whiteTransparency
        case zeus
        
        var value: UIColor {
            switch self {
            case .white:
                return UIColor(hexString: "FFFFFF")!
            case .black:
                return UIColor(hexString: "000000")!
                
            //MARK: - TEYE THEME
            case .anakiwa:
                return UIColor(hexString: "98DAFC")!
            case .tumbleweed:
                return UIColor(hexString: "DAAD86")!
            case .balticSea:
                return UIColor(hexString: "312C32")!
                
            //MARK: - WELL STORIED THEME
            case .zeus :
                return UIColor(hexString: "262216")!
            case .mondo :
                return UIColor(hexString: "49412C")!
            case .capePalliser :
                return UIColor(hexString: "97743A")!
            case .hillary :
                return UIColor(hexString: "B0A18E")!
                
            //MARK: - NAMALE
            case .conch:
                return UIColor(hexString: "C5D5CB")!
            case .pewter:
                return UIColor(hexString: "9FA8A3")!
            case .satinLinen:
                return UIColor(hexString: "E3E0CF")!
                
            //MARK: - LEVEL
            case .edgewater:
                return UIColor(hexString: "C0DFD9")!
            case .greenWhite:
                return UIColor(hexString: "E9ECE5")!
            case .submarine:
                return UIColor(hexString: "B3C2BF")!
            case .tuatara:
                return UIColor(hexString: "3B3A36")!
                
            //MARK: - GENERIC
            case .whiteTransparency:
                return UIColor(hexString: "#FFFFFF", alpha: 0.75)!
            case .transparent:
                return UIColor(hexString: "#FFFFFF", alpha: 0.0)!
                
            }
        }
    }
}

