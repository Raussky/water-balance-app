//
//  Helper.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI

struct LineModel : Identifiable, Codable {
    var id = UUID()
    var volume: Int
    var hours: Int
    var minutes: Int
}

struct DayModel: Identifiable, Codable {
    var id = UUID()
    var date: String
    var intakeLines = [LineModel]()
}

func get_day (d: Date) -> Int {
    let calendar = Calendar.current
    let day: Int = calendar.component(.day, from: d)
    return day
}

func get_month (d: Date) -> Int {
    let calendar = Calendar.current
    let month: Int = calendar.component(.month, from: d)
    return month
}

func get_year (d: Date) -> Int {
    let calendar = Calendar.current
    let year: Int = calendar.component(.year, from: d) % 2000
    return year
}

func get_min (d: Date) -> Int {
    let calendar = Calendar.current
    let minutes: Int = calendar.component(.minute, from: d)
    return minutes
}

func get_hour (d: Date) -> Int {
    let calendar = Calendar.current
    let minutes: Int = calendar.component(.hour, from: d)
    return minutes
}

func get_day_of_week (d: Date) -> String {
    let weekDays = ["Sanday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let calendar = Calendar.current
    let weekDayNr = calendar.component(.weekday, from: d) - 1
    return weekDays[weekDayNr]
}

func getMonth(d: Date) -> String {
    let monthes = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    return monthes[get_month(d: d) - 1]
}

class Storage {
    @AppDataStorage(key: "historyArr", defaultValue: [DayModel]())
    static var dayModels
}



@propertyWrapper
struct AppDataStorage<T : Codable> {
    private let key: String
    private let defaultValue: T // Generi
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get{
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else{
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
            
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
