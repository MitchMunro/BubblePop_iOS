//
//  MenuViuew.swift
//  BubblePopAssessment
//
//  Created by Mitch Munro on 2/4/2024.
//  We did it.
//

import SwiftUI

struct MenuView: View {
    
    @StateObject var viewModel = MenuViewModel()
    
    var body: some View {
        NavigationStack(){
            VStack{
                Spacer()
                TopBubblePopText
                Spacer()
                
                ButtonComponent(destination: AnyView(SettingsView()), buttonText: "Play Game", buttonColor: .purple)
                    .padding(.vertical)
                
                ButtonComponent(destination: AnyView(
                    HighScoreView()), buttonText: "High Scores", buttonColor: .indigo)
                
                Spacer()
                BottomBubblePopText
                Spacer()
            }
        }
    }
    
    var TopBubblePopText: some View{
        VStack{
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .white : .green)
                .fontWeight(.bold)
                .onReceive(viewModel.timer) {_ in
                    viewModel.isColorFlip.toggle()}                  //isColorFlip is toggled here
                .animation(Animation.easeInOut(duration: 0.4),
                           value: viewModel.isColorFlip)
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .white : .mint)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 0.5),
                           value: viewModel.isColorFlip)
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .white : .teal)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 0.6),
                           value: viewModel.isColorFlip)
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .white : .cyan)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 0.7),
                           value: viewModel.isColorFlip)
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .white : .indigo)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 0.8),
                           value: viewModel.isColorFlip)
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .orange : .purple)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 1),
                           value: viewModel.isColorFlip)
        }
    }
    
    var BottomBubblePopText: some View{
        VStack{
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .orange : .purple)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 1),
                           value: viewModel.isColorFlip)
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .white : .indigo)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 0.8),
                           value: viewModel.isColorFlip)
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .white : .cyan)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 0.7),
                           value: viewModel.isColorFlip)
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .white : .teal)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 0.6),
                           value: viewModel.isColorFlip)
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .white : .mint)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 0.5),
                           value: viewModel.isColorFlip)
            Text("BubblePop")
                .font(.largeTitle)
                .foregroundColor(viewModel.isColorFlip ? .white : .green)
                .fontWeight(.bold)
                .animation(Animation.easeInOut(duration: 0.4),
                           value: viewModel.isColorFlip)
        }
    }
}

#Preview {
    NavigationStack{
        MenuView()    
    }
}
