//
//  ButtonComponent.swift
//  BubblePopAssessment
//
//  Created by Mitch Munro on 25/4/2024.
//

import SwiftUI

struct ButtonComponent: View {
    
    let destination: AnyView
    let buttonText: String
    let buttonColor: Color
    
    init(destination: AnyView = AnyView(MenuView()),
         buttonText: String = "Button",
         buttonColor: Color = .indigo){
        self.destination = destination
        self.buttonText = buttonText
        self.buttonColor = buttonColor
    }
    
    var body: some View {
        NavigationLink{
            destination
        } label:{
            Text(buttonText)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(buttonColor)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                .padding(.horizontal)
        }
    }
}

#Preview {
    ButtonComponent()
}
