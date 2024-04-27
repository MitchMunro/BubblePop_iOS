//
//  HighScoreModel.swift
//  BubblePopAssessment
//
//  Created by Mitch Munro on 26/4/2024.
//

import Foundation

struct HighScore: Identifiable, Hashable {
    var id  = UUID().uuidString
    var playerName: String
    var score: Int
}
