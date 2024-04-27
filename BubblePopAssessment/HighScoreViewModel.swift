//
//  HighScoreViewModel.swift
//  BubblePopGame
//
//  Created by Firas Al-Doghman on 29/3/2024.
//  Edited by Mitchell Munro
//
import Foundation
import SwiftUI
import Stitch

class HighScoreViewModel: AnyObservableObject, ObservableObject {
    
    let userDefaults = UserDefaults.standard
    
    @Published var playerName: String = "Player"
    @Published var score: Int = 0
    @Published var highScoresList: [HighScore] = []
    
    let highScoreNames = [
    "HighScore1",
    "HighScore2",
    "HighScore3",
    "HighScore4",
    "HighScore5",
    "HighScore6",
    "HighScore7",
    "HighScore8",
    "HighScore9",
    "HighScore10",
    ]
    
    // UserDefaults gives us access to store slightly more complex data such as arrays
    // When using user defaults we have to manually retrieve and save the data
    init() {
        LoadHighScoresFromDevice()
        SortLoadedHighScores()
    }
    
    // Adding a new score to the array and saving this array to UserDefaults
    public func AddToHighScoreList(playerName: String, score: Int) {
        
        SortLoadedHighScores()
        
        if let lastHighScore = highScoresList.last{
            if score > lastHighScore.score{
                
                highScoresList[highScoresList.count - 1] = HighScore(playerName: playerName, score: score)
                
                SortLoadedHighScores()
                SaveHighScoresToDevice()
            }
        }
    }
    
    func ReturnHighestScore() -> Int {
        if highScoresList.isEmpty{
            return 0
        }
        else{
            return highScoresList[0].score
        }
    }
    
    func LoadHighScoresFromDevice(){
        
        ResetHighScores()
        
        guard let loadedHighScorePlayers = userDefaults.dictionary(forKey: "highScorePlayers") as? [String: String] else {
            print("Error loading HighScorePlayers.")
            return
        }
        
        guard let loadedHighScores = userDefaults.dictionary(forKey: "highScores") as? [String: Int] else {
            print("Error loading HighScores.")
            return
        }
        
        for i in 0...highScoreNames.count - 1 {
            
            var highScore = HighScore(playerName: "Player", score: 0)
            
            if let name = loadedHighScorePlayers[highScoreNames[i]] {
                
                
                //This checks if the name is only white space. If so, it give the player name "Player", instead of "".
                if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                    highScore.playerName = "Player"
                }
                else{
                    highScore.playerName = name
                }
            }
  
            if let HS = loadedHighScores[highScoreNames[i]] {
                highScore.score = HS
            }
            
            highScoresList.append(highScore)
        }
        
        SortLoadedHighScores()
    }
    
    func SaveHighScoresToDevice(){
        var playersDictionary: [String: String] = [:]
        
        for i in 0...highScoreNames.count - 1{
            playersDictionary[highScoreNames[i]] = highScoresList[i].playerName;
        }
        
        var scoresDictionary: [String: Int] = [:]
        
        for i in 0...highScoreNames.count - 1{
            scoresDictionary[highScoreNames[i]] = highScoresList[i].score;
        }
        
        userDefaults.setValue(playersDictionary, forKey: "highScorePlayers")
        
        userDefaults.setValue(scoresDictionary, forKey: "highScores")
    }
    
    func SortLoadedHighScores(){
        highScoresList.sort {$0.score > $1.score}
    }
    
    func ResetHighScores(){

        highScoresList = [
            HighScore(playerName: "Player", score: 0),
            HighScore(playerName: "Player", score: 0),
            HighScore(playerName: "Player", score: 0),
            HighScore(playerName: "Player", score: 0),
            HighScore(playerName: "Player", score: 0),
            HighScore(playerName: "Player", score: 0),
            HighScore(playerName: "Player", score: 0),
            HighScore(playerName: "Player", score: 0),
            HighScore(playerName: "Player", score: 0),
            HighScore(playerName: "Player", score: 0),
        ]
    }
    
    func DeleteHighScoresFromDevice(){
        userDefaults.removeObject(forKey: "highScorePlayers")
        userDefaults.removeObject(forKey: "highScores")
        
        LoadHighScoresFromDevice()
    }
}

extension DependencyMap {
    private struct HighScoreViewModelKey: DependencyKey {
        static var dependency: HighScoreViewModel = HighScoreViewModel()
    }
    
    var highScoreViewModel: HighScoreViewModel {
        get { resolve(key: HighScoreViewModelKey.self) }
        set { register(key: HighScoreViewModelKey.self, dependency: newValue) }
    }
}
