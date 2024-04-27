//
//  GameViewModel.swift
//  BubblePopAssessment
//
//  Created by Mitch Munro on 2/4/2024.
//

import Foundation
import SwiftUI
import Stitch

class GameViewModel: ObservableObject {
    
    @StitchObservable(\.highScoreViewModel) var highScoreViewModel
    
    @Published var gameTimeTotal: Int
    @Published var gameTimeLeft: Int = 0
    @Published var bubbles: [Bubble] = []
    @Published var score: Int = 0
    @Published var isGamePlaying: Bool = true
    @Published var isPreGame: Bool = true
    @Published var playerName = "PlayerName"
    @Published var preGameCount = 4
    @Published var preGameString = ""
    var maxNumberBubbles: Int
    
    var xBoundsMin: Int = 0
    var xBoundsMax: Int = 390
    var yBoundsMin: Int = 120
    var yBoundsMax: Int = 700
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(gameTimeTotal: Int, playerName: String, maxNumberBubbles: Int) {
        self.gameTimeTotal = gameTimeTotal
        
        gameTimeLeft = gameTimeTotal
        self.playerName = playerName
        self.maxNumberBubbles = maxNumberBubbles
    }
    
    func reset(){
        bubbles.removeAll()
        score = 0
        gameTimeLeft = gameTimeTotal
        isGamePlaying = true
        isPreGame = true
    }
    
    func decreasingFraction() -> Double {
        return Double(gameTimeLeft) / Double(gameTimeTotal)
    }
    
    func preGameCountdown(){
        let textFade = 0.7
        
        if isPreGame{
            preGameCount -= 1
            
            switch preGameCount{
            case 3:
                preGameString = "3"
                DispatchQueue.main.asyncAfter(deadline: .now() + textFade){
                    self.preGameString = ""
                    }
                break
                
            case 2:
                preGameString = "2"
                DispatchQueue.main.asyncAfter(deadline: .now() + textFade){
                    self.preGameString = ""
                    }
                break
                
            case 1:
                preGameString = "1"
                DispatchQueue.main.asyncAfter(deadline: .now() + textFade){
                    self.preGameString = ""
                    }
                break
                
            case 0:
                preGameString = "GO!"
                DispatchQueue.main.asyncAfter(deadline: .now() + textFade){
                    self.preGameString = ""
                    }
                break
                
            default:
                break;
            }

            if preGameCount <= 0{
                isPreGame = false
            }
        }
    }
    
    func countdown(){
        if gameTimeLeft > 0 {
            gameTimeLeft -= 1
            return
        }
        else if gameTimeLeft <= 0 {
            isGamePlaying = false;
        }
    }
    
    func removeAndGenerateBubbles(){
        removeSomeOldBubbles()
        generateBubbles()
    }
    
    private func removeSomeOldBubbles(){
        let numberOfBubblesRemoved = Int.random(in: 2...6)
        
        for _ in 0...numberOfBubblesRemoved{
            guard bubbles.count > 0 else{
                return
            }
            
            let randomIndex = Int.random(in: 0...bubbles.count - 1)
            
            bubbles[randomIndex].isRemoved = true;
            
            if Int(bubbles[randomIndex].position.x) > xBoundsMax / 2{
                bubbles[randomIndex].position.x = bubbles[randomIndex].position.x + CGFloat(xBoundsMax)
            }
            else {
                bubbles[randomIndex].position.x = bubbles[randomIndex].position.x - CGFloat(xBoundsMax)
            }
            
            bubbles[randomIndex].size = 0
            
            let ID: String = bubbles[randomIndex].id
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
                if let index = self.bubbles.firstIndex(where: { $0.id == ID }){
                    self.bubbles.remove(at: index)
                }
            }
        }
    }
    
    let bubbleSizeMin = 40
    let bubbleSizeMax = 65
    
    private func generateBubbles(){
        let numberOfBubblesAdd = Int.random(in: 3...10)
        
        for _ in 0...numberOfBubblesAdd{
            
            if bubbles.count >= maxNumberBubbles{
                return
            }
            
            var lookingForOpenSpace = true
            var timesTried: Int = 0
            
            while lookingForOpenSpace{
                timesTried += 1
                
                if timesTried >= 100{
                    lookingForOpenSpace = false
                    continue
                }
                
                // Calculated the useable area where no bubbles are overlapping the edge of the screen
                let xBoundsMinSafe = Int(xBoundsMin + (bubbleSizeMax + 1) / 2)
                let xBoundsMaxSafe = Int(xBoundsMax - (bubbleSizeMax + 1) / 2)
                let yBoundsMinSafe = Int(yBoundsMin + (bubbleSizeMax + 1) / 2)
                let yBoundsMaxSafe = Int(yBoundsMax - (bubbleSizeMax + 1) / 2)
                
                let position = CGPoint(x: Int.random(in: xBoundsMinSafe...xBoundsMaxSafe),
                                   y: Int.random(in: yBoundsMinSafe...yBoundsMaxSafe))
                let size = CGFloat(Int.random(in: bubbleSizeMin...bubbleSizeMax))
                let newBubble = Bubble.CreateRandomBubble(position: position, size: size)
                
                let newBubbleFrame = CGRect(x: newBubble.position.x - newBubble.size / 2,
                                            y: newBubble.position.y - newBubble.size / 2,
                                            width: newBubble.size,
                                            height: newBubble.size)
                var isOverlapping = false
                
                for bubble in bubbles {
                    let oldBubbleFrame = CGRect(x: bubble.position.x - bubble.size / 2,
                                                y: bubble.position.y - bubble.size / 2,
                                                width: bubble.size,
                                                height: bubble.size)
                    
                    if newBubbleFrame.intersects(oldBubbleFrame){
                        isOverlapping = true
                        break
                    }
                }
                
                if isOverlapping {
                    continue
                }
                else{
                    bubbles.append(newBubble)
                    lookingForOpenSpace = false
                }
            }
        }
    }
    
    var lastColorTapped: Color = .white
    
    func ScoreBubble(bubble: Bubble){
        if bubble.color == lastColorTapped{
            let scoreDouble = Double(bubble.points) * 1.5;
            
            score += Int(scoreDouble.rounded())
        }
        else{
            score += bubble.points;
        }
        
        lastColorTapped = bubble.color
        
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
                self.bubbles.remove(at: index)
            }
    }
    
    func GameFinished(){
        highScoreViewModel.AddToHighScoreList(playerName: playerName, score: score)
    }
    
}
