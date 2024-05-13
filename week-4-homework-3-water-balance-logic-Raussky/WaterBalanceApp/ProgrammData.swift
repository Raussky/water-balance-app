//
//  ProgrammData.swift
//  WaterBalanceApp
//
//  Created by Admin on 23.04.2023.
//

import SwiftUI

class ProgrammData: ObservableObject {
    @Published var currentDaylyIntake = getGoalVolume()
    @Published var currentGoalnumber = UserDefaults.standard.string(forKey: "activeGoal") ?? "goal1"
    @Published var currentReminder = UserDefaults.standard.integer(forKey: "activeReminder ")
    @Published var historyArray = Storage.dayModels
    @Published var today = ""
    @Published var yesterday = ""
}

