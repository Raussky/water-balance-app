//
//  History.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI

struct History: View {
    let headerColor:Color = Color(red: 5.0 / 255, green: 165.0 / 255, blue:239.0 / 255, opacity: 1.0)

    @ObservedObject var data: ProgrammData
    var body: some View {
        VStack{
            Text("HISTORY")
                .font(.system(size: 17,weight: .heavy))
                .italic()
                .foregroundColor(headerColor)
            List {
                ForEach(data.historyArray) {line in
                
                    Section(header:Text(header(d:data,listData:line))
                                .font(.system(size: 20,weight: .semibold))) {
                        ForEach(line.intakeLines) {line1 in
                            HStack(alignment: .center, spacing: 0) {
                                Text("\(line1.volume) ml")
                                Spacer()
                                Text("\((line1.hours),specifier:"%02d"):\((line1.minutes),specifier:"%02d")")
                            }
                            
                        }
                    }
                }
            }
   
        }
    }

}
struct historyItem: View {
    var sign: String = ""
    var val: String = "    "
    var body: some View{
        HStack {
            Text(sign)
                .frame(width: 309, height: 22, alignment: .leading)
            Text(val)
                .frame(width: 41, height: 22, alignment: .leading)
        }
    }
}
struct History_Previews: PreviewProvider {
    static var previews: some View {
        History(data: ProgrammData())
    }
}

func header(d: ProgrammData, listData: DayModel) -> String {
    var res = ""
    switch listData.date {
    case d.today:
        res = "Today"
    case d.yesterday:
        res = "Yesterday"
    default:
        res = listData.date
    }
    return res
}
