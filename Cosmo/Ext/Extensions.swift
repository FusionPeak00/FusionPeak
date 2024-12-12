//
//  Extensions.swift
//
//  Created by D K on 02.12.2024.
//

import SwiftUI


extension View {
    func size() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
}

extension Color {
    static let darkPurple = Color(#colorLiteral(red: 0.0862745098, green: 0.05490196078, blue: 0.1568627451, alpha: 1))
    static let semiPurple = Color(#colorLiteral(red: 0.1450980392, green: 0.09019607843, blue: 0.2823529412, alpha: 1))
    static let lightPurple = Color(#colorLiteral(red: 0.4588235294, green: 0.2823529412, blue: 0.9294117647, alpha: 1))
    
    static let firstGrad = Color(#colorLiteral(red: 0.6078431373, green: 0.5215686275, blue: 0.8, alpha: 1))
    static let secondGrad = Color(#colorLiteral(red: 0.4470588235, green: 0.2862745098, blue: 0.8039215686, alpha: 1))
}
