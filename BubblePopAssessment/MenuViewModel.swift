//
//  MenuViewModel.swift
//  BubblePopAssessment
//
//  Created by Mitch Munro on 27/4/2024.
//

import Foundation

class MenuViewModel: ObservableObject{
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var isColorFlip = false
}
