//
//  GameStatsModel.swift
//  BubblePopAssessment
//
//  Created by Mitch Munro on 25/4/2024.
//

import Foundation

struct GameStatsModel: Identifiable{
    var id: ObjectIdentifier
    
    var score: Int
    var bubblesPopped: Int
}
