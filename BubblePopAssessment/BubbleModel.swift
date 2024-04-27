//
//  BubbleModel.swift
//  BubblePopAssessment
//
//  Created by Mitch Munro on 24/4/2024.
//

import Foundation
import SwiftUI

class Bubble: Identifiable{
    let id: String = UUID().uuidString
    var position: CGPoint
    var size: CGFloat
    var color: Color
    let points: Int
    
    var isRemoved = false;
    
    init(position: CGPoint, size: CGFloat = 0.0, color: Color = .red, points: Int = 1) {
        self.position = position
        self.size = size
        self.color = color
        self.points = points
    }
    
    static func CreateRandomBubble(position: CGPoint, size: CGFloat = 0.0) -> Bubble{
        
        let chance = Int.random(in: 1...100)
        
        switch chance{
        case 1...40:
            return Bubble(position: position, size: size, color: .red, points: 1)
            
        case 41...70:
            return Bubble(position: position, size: size, color: Color(red: 1.0, green: 0.0, blue: 0.8), points: 2)
            
        case 71...85:
            return Bubble(position: position, size: size, color: .green, points: 5)
            
        case 86...95:
            return Bubble(position: position, size: size, color: .blue, points: 8)
            
        case 96...100:
            return Bubble(position: position, size: size, color: .black, points: 10)
            
        default:
            return Bubble(position: position, size: size, color: .red, points: 1)
        }
        
        
        
    }
}
