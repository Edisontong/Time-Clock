//
//  Utilities.swift
//  Time_Clock App
//
//  Created by Eddie Tong on 2/14/23.
//
import Foundation


private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

func formattedTime(seconds: Int) -> String {
    let (hours, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: seconds)
    let hoursString = hours
    var minutesString = "00"
    if minutes < 10 {
        minutesString = "0\(minutes)"
    } else {
        minutesString = String(minutes)
    }
    var secondsString = "00"
    if seconds < 10 {
        secondsString = "0\(seconds)"
    } else {
        secondsString = String(seconds)
    }
    if hours >= 1 {
        return "\(hoursString):\(minutesString):\(secondsString)"
    } else {
        return "\(minutesString):\(secondsString)"
    }
}


func saveDays(_ days: [Day]) {
    let data = days.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: "Days")
    print("Saved")
}


func loadDays() -> [Day] {
    print("LOAD")
    guard let encodedData = UserDefaults.standard.array(forKey: "Days") as? [Data] else {
        return []
    }
    return encodedData.map { try! JSONDecoder().decode(Day.self, from: $0) }
}
