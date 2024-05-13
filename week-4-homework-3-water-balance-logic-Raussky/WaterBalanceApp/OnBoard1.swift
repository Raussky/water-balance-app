//
//  OnBoard1.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI

struct OnBoard1: View {
    @Binding var isFistTime: Bool
    let headerColor:Color = Color(red: 5.0 / 255, green: 165.0 / 255, blue:239.0 / 255, opacity: 1.0)
    @AppStorage("activeGoal")
    var activeGoal = ""
    @State var isNext = false
    @ObservedObject var data: ProgrammData
    
    var title : some View {  Text("WATER BALANCE")
        .font(.system(size: 24, weight: .heavy))
        .italic()
        .foregroundColor(Color(red: 5.0 / 255, green: 165.0 / 255, blue:239.0 / 255, opacity: 1.0))
        .padding(.bottom, 62)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $isNext) {
                    OnBoard2(isFirstTime: $isFistTime, data: data)
                } label: {
                    EmptyView()
                }

                title
                Spacer()
                Text("What is your goal?")
                    .font(.system(size: 36))
                Spacer()
                    //.foregroundColor(.blue)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 212 / 255, green: 225 / 255, blue: 248 / 255))
                        .frame(width: 358, height: 330)
                    VStack {
                        GoalPane(title: "Goal number one", goalNomber: "goal1", activeGoal: $activeGoal)
                        GoalPane(title: "Goal number two", goalNomber: "goal2", activeGoal: $activeGoal)
                        GoalPane(title: "Goal number three", goalNomber: "goal3", activeGoal: $activeGoal)
                        GoalPane(title: "Goal number four", goalNomber: "goal4", activeGoal: $activeGoal)
                    }
                }
            Spacer()
                NextButton(title: "Next") {
                    isNext = true
                    data.currentGoalnumber = activeGoal
                }// Next buton
            }
        }
    }
    
}
struct NextButton: View {
    var title: String = ""
    var action: () -> Void = { }
    var body: some View {
        Button (action: action)
        {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(.blue)
                    .frame(width: 358, height: 60)
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                
            }
        }
    }
}

struct GoalPane: View {
    var title: String
    var goalNomber: String
    @Binding
    var activeGoal: String
    
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 252 / 255, green: 253 / 255, blue: 255 / 255))
            HStack{
                Text(title)
                    .padding()
                Spacer()
                    
                RadioButton(goalNomber: goalNomber, activeGoal: $activeGoal)
                    .frame(width: 18, height: 18)
                    .padding()
            }
        }
        .frame(width: 320, height: 60)
    }
}

struct RadioButton: View {
    var goalNomber: String
    @Binding
    var activeGoal: String   
    var body: some View {
        Group{
            if activeGoal == goalNomber {
                ZStack{
                    Circle()
                        .stroke(Color.blue,lineWidth: 2.5)
                        .frame(width: 20, height: 20)
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 12, height: 12)
                }
                .onTapGesture {
                    activeGoal = ""
                }
            } else {
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .overlay(Circle().stroke(Color.blue, lineWidth: 1))
                    .onTapGesture {
                        UserDefaults.standard.set(goalNomber, forKey: "activeGoal")
                        activeGoal = goalNomber
                    }
            }
    }
}
}
struct OnBoard1_Previews: PreviewProvider {
    static var previews: some View {
        OnBoard1(isFistTime: .constant(false), data: ProgrammData())
    }
}
