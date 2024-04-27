//
//  TestAnimation.swift
//  BubblePopAssessment
//
//  Created by Mitch Munro on 26/4/2024.
//

import SwiftUI

struct TestAnimation: View {
    
    @State var isToggled = false
    
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                Circle()
                    .position(CGPoint(x: 200, y: 100.0))
                    .offset(y: isToggled ? 600 : 0)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.black)
                    .onTapGesture{
                        withAnimation(.spring()){
                            isToggled.toggle()
        
                        }
                        print("Clicked")
                    }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            // Code to be executed after 5 seconds
                            print("This will be printed after 5 seconds")
                            withAnimation(.spring(duration: 10)){
                                isToggled.toggle()
                            } 
                        }
                    }
            }
        }
        
        
    }
}

#Preview {
    TestAnimation()
}
