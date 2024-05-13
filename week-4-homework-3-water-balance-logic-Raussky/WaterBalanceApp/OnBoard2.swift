//
//  OnBoard2.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI

struct OnBoard2: View {
    let headerColor:Color = Color(red: 5.0 / 255, green: 165.0 / 255, blue:239.0 / 255, opacity: 1.0)
    @State var activeReminder: Int = UserDefaults.standard.integer(forKey: "activeReminder")
    @State var isNext = false
    @Binding var  isFirstTime: Bool
    @ObservedObject var data: ProgrammData
    var body: some View {
        VStack {
            NavigationLink(isActive: $isNext) {
                OnBoard3(goalNomber: UserDefaults.standard.string(forKey: "activeGoal") ?? "goal1", isFistTime: $isFirstTime, data: data)
            } label: {
                EmptyView()
            }

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
                        RemindButton(title: "15 minutes", reminderTime: 15, isActive: $activeReminder)
                        RemindButton(title: "30 minutes", reminderTime: 30, isActive: $activeReminder)
                    }
                    HStack{
                        RemindButton(title: "45 minutes", reminderTime: 45, isActive: $activeReminder)
                        RemindButton(title: "1 hour",reminderTime: 60, isActive: $activeReminder)
                    }
                    HStack{
                        RemindButton(title: "1,5 hours",reminderTime: 90, isActive: $activeReminder)
                        RemindButton(title: "2 hours",reminderTime: 120, isActive: $activeReminder)
                    }
                    HStack{
                        RemindButton(title: "3 hours",reminderTime: 180, isActive: $activeReminder)
                        RemindButton(title: "4 hours",reminderTime: 240, isActive: $activeReminder)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .padding(.bottom,116)
            NextButton(title: "Next") {
                UserDefaults.standard.set(activeReminder, forKey: "activeReminder")
                data.currentReminder = activeReminder
                
                isNext = true
            }
        }
    }
}
struct LeftButton: View {
    var action: () -> Void = { }
    var body: some View{
        Button(action: action)
        {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
        }
    }
}
struct RemindButton: View {
    var title: String
    var reminderTime: Int
    @Binding var isActive: Int
    var action: () -> Void = { }
    var body: some View {
        Button {
            isActive = reminderTime
        } label: {
            ZStack{
                Group{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.blue, lineWidth: isActive == reminderTime ? 2.5:0)
                }
                    .frame( height: 60)
                   
                Text(title)
                    .foregroundColor(.black)
                    .font(.system(size: 22))
                
            }
        }
    }
}
struct OnBoard2_Previews: PreviewProvider {
    static var previews: some View {
        OnBoard2(activeReminder: 0, isFirstTime: .constant(false), data: ProgrammData())
    }
}
