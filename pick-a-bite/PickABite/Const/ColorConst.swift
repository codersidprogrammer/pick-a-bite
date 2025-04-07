//
//  ColorConst.swift
//  kemekuy
//
//  Created by Dimaseditiya on 15/03/25.
//

import SwiftUI

extension Color {
    init(hex: String, opacity: Double? = nil) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var int: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&int)
        
        var r, g, b, a: UInt64
        switch hexSanitized.count {
        case 3: // RGB (12-bit, like #F0A)
            (r, g, b, a) = (
                ((int >> 8) & 0xF) * 17,
                ((int >> 4) & 0xF) * 17,
                (int & 0xF) * 17,
                255
            )
        case 6: // RGB (24-bit, like #FFAA33)
            (r, g, b, a) = (
                (int >> 16) & 0xFF,
                (int >> 8) & 0xFF,
                int & 0xFF,
                255
            )
        case 8: // RGBA (32-bit, like #FFAA33CC)
            (r, g, b, a) = (
                (int >> 24) & 0xFF,
                (int >> 16) & 0xFF,
                (int >> 8) & 0xFF,
                int & 0xFF
            )
        default:
            (r, g, b, a) = (0, 0, 0, 255) // fallback to black
        }
        
        let finalOpacity = opacity ?? Double(a) / 255.0
        self.init(.sRGB, red: Double(r) / 255.0, green: Double(g) / 255.0, blue: Double(b) / 255.0, opacity: finalOpacity)
    }
    
    struct Maroon {
        static let shade50  = Color(hex: "#F8E8E8")
        static let shade100 = Color(hex: "#F0D1D1")
        static let shade200 = Color(hex: "#E1A3A3")
        static let shade300 = Color(hex: "#D27474")
        static let shade400 = Color(hex: "#C24242")
        static let shade500 = Color(hex: "#973131")
        static let shade600 = Color(hex: "#772727")
        static let shade700 = Color(hex: "#5C1E1E")
        static let shade800 = Color(hex: "#3E1414")
        static let shade900 = Color(hex: "#1F0A0A")
        static let shade950 = Color(hex: "#0F0505")
    }
    
    struct Orange {
        static let shade50  = Color(hex: "#FCF6EE")
        static let shade100 = Color(hex: "#F8ECDD")
        static let shade200 = Color(hex: "#F3DCBF")
        static let shade300 = Color(hex: "#ECCA9D")
        static let shade400 = Color(hex: "#E6B97F")
        static let shade500 = Color(hex: "#E0A75E")
        static let shade600 = Color(hex: "#D68B29")
        static let shade700 = Color(hex: "#9E671E")
        static let shade800 = Color(hex: "#6B4615")
        static let shade900 = Color(hex: "#33210A")
        static let shade950 = Color(hex: "#1A1105")
    }
    
    struct Beige {
        static let shade50  = Color(hex: "#FFFCF5")
        static let shade100 = Color(hex: "#FEF6E7")
        static let shade200 = Color(hex: "#FDEECE")
        static let shade300 = Color(hex: "#FBE5B6")
        static let shade400 = Color(hex: "#FADFA3")
        static let shade500 = Color(hex: "#F9D689")
        static let shade600 = Color(hex: "#F5BC42")
        static let shade700 = Color(hex: "#DA990B")
        static let shade800 = Color(hex: "#926607")
        static let shade900 = Color(hex: "#493304")
        static let shade950 = Color(hex: "#271B02")
    }
    
    struct Yellow {
        static let shade50  = Color(hex: "#FEFCF6")
        static let shade100 = Color(hex: "#FDFBF1")
        static let shade200 = Color(hex: "#FBF5DF")
        static let shade300 = Color(hex: "#F9F1D2")
        static let shade400 = Color(hex: "#F7EBC0")
        static let shade500 = Color(hex: "#F5E7B2")
        static let shade600 = Color(hex: "#EBCE66")
        static let shade700 = Color(hex: "#E2B71D")
        static let shade800 = Color(hex: "#957913")
        static let shade900 = Color(hex: "#4D3E0A")
        static let shade950 = Color(hex: "#241D05")
    }
    
    static let primary = Maroon.shade500
    static let secondary = Orange.shade500
}

