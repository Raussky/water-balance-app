//
//  Main1.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI

struct Main1: View {
    let headerColor:Color = Color(red: 5.0 / 255, green: 165.0 / 255, blue:239.0 / 255, opacity: 1.0)
    let gradientStart = Color(red: 212.0 / 255, green: 225.0 / 255, blue:248.0 / 255, opacity: 1.0)

    let gradientEnd = Color(red: 212.0 / 255, green: 225.0 / 255, blue:248.0 / 255, opacity: 0.0)
    @State var waterAmount = 0.0 // that is value that you've already drunk.Try to change it, you'll see the changes jn the screen :)
    //let fullVal = getGoalVolume()//2.4 // that is value you have to drink
    var header: String = ""
    @State var date = Date()
   @State var isWaterIntake = false
    @ObservedObject var data: ProgrammData
    var body: some View {
        NavigationView {
        VStack {
            NavigationLink(isActive: $isWaterIntake) {
                Water_intake(daylyVolume: $waterAmount, isActive: $isWaterIntake, data: data)
            } label: {
                EmptyView()
            }

            Text("WATER BALANCE " )
                .font(.system(size: 24, weight: .black))
                .italic()
                .foregroundColor(headerColor)
                .padding(.bottom, 32)
            ZStack {
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]),
                                       startPoint: .top,
                                       endPoint: .bottom))
                VStack {
                    ZStack {
                        Group{
                            Circle()
                                .stroke(.white, lineWidth: 10)
                                .frame(width: 180, height: 180, alignment: .center)
                            Circle()
                                .trim(from: 0, to: CGFloat(calculatePercenttage(val: waterAmount, fullVal: data.currentDaylyIntake)/100.0))
                                .fill(.blue)
                                .rotationEffect(.degrees(Double(90 - offsetVal(percent: calculatePercenttage(val: waterAmount, fullVal: data.currentDaylyIntake)))))
                                .frame(width: 160, height: 160)
                            VStack{
                                Text(" \((calculatePercenttage(val: waterAmount, fullVal: data.currentDaylyIntake)),specifier: "%.f") %")
                                    .font(.system(size: 36,weight: .bold))
                                Text( String(waterAmount) + " out of " + String(data.currentDaylyIntake) + "L" )
                            }
                        }
                        .padding(.bottom, 68)
                    }
                    Text(get_day_of_week(d: date) + ", \(get_day(d: date))th of " + getMonth(d: date))
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                        .padding(.bottom, 32)
                }
            }
            .frame(width: 358, height: 332)
           
            Text(sign(perc: calculatePercenttage(val: waterAmount, fullVal: data.currentDaylyIntake/1000)))
                .font(.system(size: 36, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
                .frame(width: 358, height: 92, alignment: .center)
            Spacer()
            NextButton(title: "Add", action: {
                isWaterIntake = true
            })
                .padding(.bottom,50)
        }
        }
    }
}
func sign(perc: Double) -> String {
    if perc > 0 {
        return "Great job!"
    }
    else {
        return "Add your fist drink for today"
    }
}

func offsetVal(percent:Double) -> Double {
    let res: Double  = percent * 1.8
    return res
}

func trim(percent :Int) -> CGFloat {
    let res: CGFloat = CGFloat(percent / 100)
    return res
}

func calculatePercenttage(val:Double, fullVal: Double) -> Double {
    return fullVal > 0 ? val * 100.0 / fullVal: 0
}

struct Main1_Previews: PreviewProvider {
    static var previews: some View {
        Main1(data: ProgrammData())
    }
}

func getGoalVolume () -> Double {
    var res = 0.0
    let key = UserDefaults.standard.string(forKey: "activeGoal") ?? "goal1"
    switch key {
    case "goal1":
         res = Double(UserDefaults.standard.integer(forKey: "goalVolume1")) /  1000
    case "goal2":
         res = Double(UserDefaults.standard.integer(forKey: "goalVolume2")) /  1000
    case "goal3":
         res = Double(UserDefaults.standard.integer(forKey: "goalVolume3")) /  1000
    case "goal4":
         res = Double(UserDefaults.standard.integer(forKey: "goalVolume4")) /  1000
    default:
        res  = 0
    }
    return res
}
