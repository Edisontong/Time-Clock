//
//  DayView.swift
//  Time_Clock App
//
//  Created by Eddie Tong on 2/14/23.
//
import SwiftUI

struct DayView: View {
    var day: Day
    @Binding var days: [Day]
    
    @State var timerStarted: Bool = false
    @State var seconds: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Text(day.name)
            Spacer()
            Text("\(formattedTime(seconds: day.time + seconds))")
                .onReceive(timer) { _ in
                    if timerStarted {
                        seconds += 1
                    }
                }
            Button {
                timerStarted.toggle()
                if !timerStarted {
                    let newTime = day.time + seconds
                    let name = day.name
                    guard let index = days.firstIndex(of: day) else { return }
                    days.remove(at: index)
                    days.append(Day(name: name, time: newTime))
                    days.sort { $0.name < $1.name }
                    saveDays(days)
                    seconds = 0
                }
            } label: {
                if timerStarted {
                    Text("Stop")
                } else {
                    Text("Start")
                }
            }

        }
    }
}
