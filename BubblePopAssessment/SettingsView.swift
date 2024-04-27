//
//  SettingsView.swift
//  BubblePopGame
//
//  Created by Firas Al-Doghman on 29/3/2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    @State private var countdownInput = ""
    @State private var countdownValue: Double = 0
    @State private var numberOfBubbles: Double = 0
    var body: some View {
            VStack{
                Text("Settings")
                    .foregroundStyle(.purple)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                NameInput
                
                Spacer()
                
                Text("Game Time: \(Int(viewModel.gameTime))")
                Slider(value: $viewModel.gameTime, in: 30...90)
                    .padding(.horizontal)
                    .accentColor(.indigo)
                
                Spacer()

                Text("Max Bubbles: \(Int(viewModel.numberOfBubbles))")
                Slider(value: $viewModel.numberOfBubbles, in: 0...15, step:1)
                    .padding(.horizontal)
                    .accentColor(.indigo)
                    .padding(.bottom, 30)
                
                Spacer()
                
                ButtonComponent(destination: AnyView(
                    GameView(
                    gameTime: Int(viewModel.gameTime),
                    playerName: viewModel.playerName.isEmpty ? "Player" : viewModel.playerName,
                    maxNumberBubbles: Int(viewModel.numberOfBubbles)
                    )
                ),
                        buttonText: "Start Game")
                
                Spacer()
                
            }
        }
    
    var NameInput: some View{
        VStack{
            
            Text("Enter your name:")
            TextField("Name", text: $viewModel.playerName)
                .padding()
                .background(Color.yellow.opacity(0.4))
                .multilineTextAlignment(.center)
                .font(.system(size: 25))
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.indigo.opacity(0.6))
                        .edgesIgnoringSafeArea(.all),
                    alignment: .top
                )
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.indigo.opacity(0.6))
                        .edgesIgnoringSafeArea(.all),
                    alignment: .bottom
                )
        }
    }
    
}
#Preview {
    SettingsView()
}
