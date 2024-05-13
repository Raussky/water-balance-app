//
//  GoalSettings.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI

struct GoalSettings: View {
    @Binding var isActive: Bool
    @State var activeGoal = UserDefaults.standard.string(forKey: "activeGoal") ?? "goal1"
    @ObservedObject var data: ProgrammData
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Text("What is your goal?")
                .font(.system(size: 36))
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 212 / 255, green: 225 / 255, blue: 248 / 255))
                    .frame( height: 330)
            VStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 252 / 255, green: 253 / 255, blue: 255 / 255))
                    HStack {
                        Text("Goal number one")
                        Spacer()
                        RadioButton(goalNomber: "goal1", activeGoal: $activeGoal)
                    }.padding(.horizontal,24)
                   
                }
                .frame( height: 60)
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 252 / 255, green: 253 / 255, blue: 255 / 255))
                    HStack {
                        Text("Goal number two")
                        Spacer()
                        RadioButton(goalNomber: "goal2", activeGoal: $activeGoal)
                    }
                    .padding(.horizontal,24)
                   
                }
                .frame( height: 60)
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 252 / 255, green: 253 / 255, blue: 255 / 255))
                    HStack {
                        Text("Goal number three")
                        Spacer()
                        RadioButton(goalNomber: "goal3", activeGoal: $activeGoal)
                    }
                    .padding(.horizontal,24)
                   
                }
                .frame( height: 60)
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 252 / 255, green: 253 / 255, blue: 255 / 255))
                    HStack {
                        Text("Goal number four")
                        Spacer()
                        RadioButton(goalNomber: "goal4", activeGoal: $activeGoal)
                    }
                    .padding(.horizontal,24)
                   
                }
                .frame( height: 60)
            }
            .padding(.horizontal, 19)
            }
            .padding(.horizontal)
            Spacer()
            NextButton(title: "Save") {
                data.currentDaylyIntake = getGoalVolume()
                print("\(data.currentDaylyIntake)")
               isActive = false
            }
   
        }
    }
}

struct GoalSettings_Previews: PreviewProvider {
    static var previews: some View {
        GoalSettings(isActive: .constant(false), data: ProgrammData())
    }
}
