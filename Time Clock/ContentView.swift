//
//  ContentView.swift
//  Time_Clock App
//
//  Created by Eddie Tong on 2/14/23.
//
import SwiftUI

struct ContentView: View {

    @State var days: [Day] = []
    
    @State var dayName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter day name", text: $dayName)
                Button {
                    days.append(Day(name: dayName, time: 0))
                    days.sort { $0.name < $1.name }
                    dayName = ""
                    saveDays(days)
                } label: {
                    Text("Save")
                }

            }
            ForEach(days, id: \.name) { day in
                DayView(day: day, days: $days)
            }
        }.padding()
        .onAppear {
            days = loadDays()
        }
    }
}
