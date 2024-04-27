//
//  SettingsViewModel.swift
//  BubblePopAssessment
//
//  Created by Mitch Munro on 2/4/2024.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var gameTime: Double = 60
    @Published var numberOfBubbles: Double = 15
    @Published var playerName: String = ""

}
