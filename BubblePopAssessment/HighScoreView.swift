//
//  HighScoreView.swift
//  BubblePopGame
//
//  Created by Firas Al-Doghman on 29/3/2024.
//  Edited by Mitchell Munro
//

import SwiftUI
import Stitch

struct HighScoreView: View {
    
    // I asked my moblie dev friend about the best way to pass data through the app
    // and he told me about Stitch dependency injection.
    @StitchObservable(\.highScoreViewModel) var highScoreViewModel
    
    var body: some View {
        
        VStack {
            Text("High Scores")
                .foregroundStyle(.purple)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            Spacer()

            ScrollView{
                DisplayScores
                    .padding(.horizontal, 20)
            }
            
            Spacer()

            //Uncomment this to test adding scores to the list
            //TestStepper
            
            Button {
                highScoreViewModel.DeleteHighScoresFromDevice()
            } label: {
                Text("Delete High Scores")
                    .font(.headline)
                    .frame(maxWidth: 180)
                    .frame(height: 24)
                    .background(.orange)
                    .foregroundStyle(.white)
            }
            .padding(.bottom, 1)
        }
    }
    
    var DisplayScores: some View{
        ForEach(highScoreViewModel.highScoresList.prefix(10), id: \.self) { HS in
            Text("\(HS.playerName)  -  \(HS.score)")
                .font(.title3)
                .foregroundColor(.indigo)
                .bold()
                .padding(.bottom, 20)
            
        }
    }
    
    var TestStepper: some View{
        VStack{
            Stepper("Score: \(highScoreViewModel.score)", value: $highScoreViewModel.score)

            Button {
                highScoreViewModel.AddToHighScoreList(playerName: highScoreViewModel.playerName, score: highScoreViewModel.score)
            } label: {
                Text("Add to scores")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .background(.red)
                    .foregroundStyle(.white)
                    .padding()
            }
        }
    }
}

#Preview {
    HighScoreView()
}
