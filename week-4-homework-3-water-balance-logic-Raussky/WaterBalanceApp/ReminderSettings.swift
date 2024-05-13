//
//  ReminderSettings.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI

struct ReminderSettings: View {
    @Binding var isActive: Bool
    @State var activeReminder: Int = UserDefaults.standard.integer(forKey: "activeReminder")
    let headerColor:Color = Color(red: 5.0 / 255, green: 165.0 / 255, blue:239.0 / 255, opacity: 1.0)
    @ObservedObject var data: ProgrammData
    var body: some View {
        VStack {

            Text("WATER BALANCE")
                .font(.system(size: 24, weight: .black))
                .italic()
                .foregroundColor(headerColor)
                .padding(.bottom, 62)
          Text("Remind me each")
                .font(.system(size: 36))
                .padding(.bottom,32)
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 212 / 255, green: 225 / 255, blue: 248 / 255))
                    .frame( height: 330)
                VStack{
                    HStack{
                        RemindButton(title: "15 minutes", reminderTime: 15 * 60, isActive: $activeReminder)
                        RemindButton(title: "30 minutes", reminderTime: 30 * 60, isActive: $activeReminder)
                    }
                    HStack{
                        RemindButton(title: "45 minutes", reminderTime: 45 * 60, isActive: $activeReminder)
                        RemindButton(title: "1 hour",reminderTime: 60 * 60, isActive: $activeReminder)
                    }
                    HStack{
                        RemindButton(title: "1,5 hours",reminderTime: 90 * 60, isActive: $activeReminder)
                        RemindButton(title: "2 hours",reminderTime: 120 * 60, isActive: $activeReminder)
                    }
                    HStack{
                        RemindButton(title: "3 hours",reminderTime: 180 * 60, isActive: $activeReminder)
                        RemindButton(title: "4 hours",reminderTime: 240 * 60, isActive: $activeReminder)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
          
            NextButton(title: "Save") {
                UserDefaults.standard.set(activeReminder, forKey: "activeReminder")
                data.currentReminder = activeReminder
                isActive = false
            }
        }
    }
}

struct ReminderSettings_Previews: PreviewProvider {
    static var previews: some View {
        ReminderSettings(isActive: .constant(true), data: ProgrammData())
    }
}
