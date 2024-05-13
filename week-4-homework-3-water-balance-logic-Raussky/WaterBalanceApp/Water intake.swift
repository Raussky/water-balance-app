//
//  Water intake.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI
import UserNotifications

struct Water_intake: View {
    @Binding var daylyVolume: Double
    @State var volume: String = ""
    @State var date = Date()
    @Binding var isActive: Bool
    @ObservedObject var data: ProgrammData
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Water intake")
                .font(.system(size: 36))
                .padding(.bottom, 32)
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 212 / 255, green: 225 / 255, blue: 248 / 255))
                    .frame(height: 108)
                
               
                HStack(alignment: .center, spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color( red: 252, green: 253, blue: 255, opacity: 1))
                            .frame(height: 60)
                        TextField("0", text: $volume)
                            .foregroundColor(.blue)
                            .disableAutocorrection(true)
                            .font(.system(size: 16))
                            .frame(width: 250, height: 60)
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                    if success {
                                        print("All set!")
                                    } else if let error = error {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                      
                    }
                   
                    Spacer()
                    Text("ML")
                        .padding(.trailing, 43)
                }
                .padding(.leading,19)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 77)
            
            NextButton(title: "Add")
            {
                var intakeVol: Int = 0
                if let a = Int(volume) {
                    intakeVol = a
                }
                var intake = LineModel(volume: intakeVol, hours: get_hour(d: date), minutes: get_min(d: date))
                let day: Int = get_day(d: date)
                let yesterday = day - 1
                let month: Int = get_month(d: date)
                let year = get_year(d: date)
                let curDate = String(day/10) + String(day%10) + "." + String(month/10) + String(month%10) + "." + String(year/10) + String(year%10)
                data.today = curDate
                data.yesterday = String(yesterday/10) + String(yesterday%10) + "." + String(month/10) + String(month%10) + "." + String(year/10) + String(year%10)
                let lastIndex =  data.historyArray.count - 1
                
                if  data.historyArray.count == 0 {
                    data.historyArray.append(DayModel( date: curDate, intakeLines: [intake]))
                } else if  data.historyArray[lastIndex].date == curDate {
                    data.historyArray[lastIndex].intakeLines.append(intake)
                } else if  data.historyArray[lastIndex].date != curDate {
                    data.historyArray.append(DayModel( date: curDate, intakeLines: [intake]))
                    daylyVolume = 0
                }
                
                daylyVolume += Double(intakeVol) / 1000
                Storage.dayModels =  data.historyArray
                
                let content = UNMutableNotificationContent()
                content.title = "It's time to drink some water bro"
                content.sound = UNNotificationSound.default

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)
                isActive = false
            }
        }
    }
}

struct Water_intake_Previews: PreviewProvider {
    static var previews: some View {
        Water_intake(daylyVolume: .constant(0.0), volume: "", isActive: .constant(true), data: ProgrammData())
    }
}
