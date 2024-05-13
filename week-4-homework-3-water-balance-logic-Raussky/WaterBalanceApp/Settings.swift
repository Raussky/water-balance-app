//
//  Settings.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI

struct Settings: View {
    let headerColor:Color = Color(red: 5.0 / 255, green: 165.0 / 255, blue:239.0 / 255, opacity: 1.0)
    @State var toDaylyIntake  = false
    @State var toGoalChooser = false
    @State var toReminderChoser = false
    @ObservedObject var data: ProgrammData
    var body: some View {
        NavigationView {
        VStack{
            Group {
            NavigationLink(isActive: $toDaylyIntake) {
                DailyIntakeSettings(isActive: $toDaylyIntake, goalNomber: UserDefaults.standard.string(forKey: "activeGoal") ?? "goal1", data: data)
            } label: {
                EmptyView()
            }
            
            NavigationLink(isActive: $toGoalChooser) {
                GoalSettings(isActive: $toGoalChooser, data: data)
            } label: {
                EmptyView()
            }
            
            NavigationLink(isActive: $toReminderChoser) {
                ReminderSettings(isActive: $toReminderChoser, data: data)
            } label: {
                EmptyView()
            }

            Text("EDIT")
                .font(.system(size: 17,weight: .black))
                .italic()
                .foregroundColor(headerColor)
                .padding(.top,28)
            settingsItem(sign: "Daily intake level", val: getCurrentVol(goalNr: UserDefaults.standard.string(forKey: "activeGoal") ?? "goal1") + " ML") {
                toDaylyIntake = true
            }
            separator
            settingsItem(sign: "Your goal") {
                toGoalChooser = true
            }
            separator
            settingsItem(sign: "Reminder") {
                toReminderChoser = true
            }
            separator
        }
    Spacer()
        }
        }
    }
    
    var separator: some View {
        Rectangle()
            .frame(width: 350, height: 0.0, alignment: .center)
            .padding()
    }
}
struct settingsItem: View {
    var sign: String = ""
    var val: String = "    "
    var action: () -> Void = { }
    var body: some View{
        HStack {
            Text(sign)
                .frame(width: 260, height: 22, alignment: .leading)
            Text(val)
                .frame(width: 60, height: 22, alignment: .leading)
            RightButton(action: action)
        }
    }
}
struct RightButton: View {
    let rightArrowColor = Color(red: 60.0 / 255, green: 60.0 / 255, blue:67.0 / 255, opacity: 0.3)
    var action: () -> Void = { }
    var body: some View{
        Button(action: action)
        {
            Image(systemName: "chevron.right")
                .foregroundColor(rightArrowColor)
        }
    }
}
struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(data: ProgrammData())
    }
}
