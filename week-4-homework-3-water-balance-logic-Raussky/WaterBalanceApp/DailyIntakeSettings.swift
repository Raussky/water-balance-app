//
//  DailyIntakeSettings.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI

struct DailyIntakeSettings: View {
    @Binding var isActive: Bool
    let headerColor:Color = Color(red: 5.0 / 255, green: 165.0 / 255, blue:239.0 / 255, opacity: 1.0)
    var goalNomber: String
    @State var volume = ""
    @ObservedObject var data: ProgrammData
    var body: some View {
        VStack{
            Text("WATER BALANCE")
                .font(.system(size: 24))
                .italic()
                .fontWeight(.black)
                .foregroundColor(headerColor)
                .padding(.top,30)
                .padding(.bottom, 62)
            
            Text("What is your goal?")
                .font(.system(size: 36))
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 212 / 255, green: 225 / 255, blue: 248 / 255))
                    .frame(height: 108)
                
               
                HStack(alignment: .center, spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color( red: 252, green: 253, blue: 255, opacity: 1))
                            .frame(height: 60)
                        TextField(getCurrentVol(goalNr: goalNomber), text: $volume)
                            .foregroundColor(.blue)
                            .disableAutocorrection(true)
                            .font(.system(size: 16))
                            .frame(width: 250, height: 60)
                            .multilineTextAlignment(.center)
                      
                    }
                   
                    Spacer()
                    Text("ML")
                        .padding(.trailing, 43)
                }
                .padding(.leading,19)
            }
            .padding(.bottom, 77)
            .padding(.horizontal, 19)
            
            NextButton(title: "Save") {
                var volSetpoint:Int = 0
                if let a = Int(volume) {
                    volSetpoint = a
                }
                    
                switch goalNomber {
                case "goal1":
                    UserDefaults.standard.set(volSetpoint, forKey: "goalVolume1")
                case "goal2":
                    UserDefaults.standard.set(volSetpoint, forKey: "goalVolume2")
                case "goal3":
                    UserDefaults.standard.set(volSetpoint, forKey: "goalVolume3")
                case "goal4":
                    UserDefaults.standard.set(volSetpoint, forKey: "goalVolume4")
                default:
                    UserDefaults.standard.set(volSetpoint, forKey: "goalVolume1")
                }
                data.currentDaylyIntake = getGoalVolume()
                isActive = false
            }
          Spacer()
        }
        .frame(width: 400, height: 780)
    }
}
func getCurrentVol (goalNr: String) -> String {
    var res = ""
    switch goalNr {
    case "goal1":
        res = String(UserDefaults.standard.integer(forKey: "goalVolume1"))
    case "goal2":
       res = String(UserDefaults.standard.integer(forKey: "goalVolume2"))
    case "goal3":
       res = String(UserDefaults.standard.integer(forKey: "goalVolume3"))
    case "goal4":
       res = String(UserDefaults.standard.integer(forKey: "goalVolume4"))
    default:
        res = "0"
    }
    return res
}

struct DailyIntakeSettings_Previews: PreviewProvider {
    static var previews: some View {
        DailyIntakeSettings(isActive: .constant(true), goalNomber: "", data: ProgrammData())
    }
}
