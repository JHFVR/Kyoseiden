//
//  editSchedule.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 18.03.24.
//

import Foundation
import SwiftUI
//import SwiftData

struct editSchedule: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
//    @Query private var schedulePreferences: [schedulePreferences]
    
    @State private var callFrequency: CallFrequency = UserDefaultsManager.callFrequency ?? .daily
    @State private var selectedDays: [DayOfWeek] = UserDefaultsManager.selectedDays ?? []
    @State private var startTime = UserDefaultsManager.startTime ?? (Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date())
    @State private var endTime = UserDefaultsManager.endTime ?? (Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: Date()) ?? Date())

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    CallFrequencyPicker(callFrequency: $callFrequency)
                        .padding()

                    DaysForCalls(selectedDays: $selectedDays)
                        .padding()

                    TimePicker(title: "Earliest Call Time", selectedTime: $startTime)
                        .padding(.horizontal)

                    TimePicker(title: "Latest Call Time", selectedTime: $endTime)
                        .padding(.horizontal)

                    NoteBox()
                        .padding()
                }
                .padding()
            }
            .navigationTitle("Scheduling")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        UserDefaultsManager.callFrequency = callFrequency
                        UserDefaultsManager.selectedDays = selectedDays
                        UserDefaultsManager.startTime = startTime
                        UserDefaultsManager.endTime = endTime
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
            }
        }        .onAppear {
            // Load preferences when the view appears question marks are for detault values
            callFrequency = UserDefaultsManager.callFrequency ?? .daily
            selectedDays = UserDefaultsManager.selectedDays ?? []
            startTime = UserDefaultsManager.startTime ?? (Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date())
            endTime = UserDefaultsManager.endTime ?? (Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: Date()) ?? Date())
        }
        Spacer()
    }
}
        

// Helper struct to manage UserDefaults operations
struct UserDefaultsManager {
    static let callFrequencyKey = "CallFrequency"
    static let selectedDaysKey = "SelectedDays"
    static let startTimeKey = "StartTime"
    static let endTimeKey = "EndTime"
    
    static var callFrequency: CallFrequency? {
        get {
            guard let rawValue = UserDefaults.standard.string(forKey: callFrequencyKey) else { return nil }
            return CallFrequency(rawValue: rawValue)
        }
        set {
            UserDefaults.standard.set(newValue?.rawValue, forKey: callFrequencyKey)
        }
    }
    
    static var selectedDays: [DayOfWeek]? {
        get {
            guard let rawData = UserDefaults.standard.array(forKey: selectedDaysKey) as? [String] else { return nil }
            return rawData.compactMap { DayOfWeek(rawValue: $0) }
        }
        set {
            let rawValues = newValue?.map { $0.rawValue }
            UserDefaults.standard.set(rawValues, forKey: selectedDaysKey)
        }
    }
    
    static var startTime: Date? {
        get {
            return UserDefaults.standard.object(forKey: startTimeKey) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: startTimeKey)
        }
    }
    
    static var endTime: Date? {
        get {
            return UserDefaults.standard.object(forKey: endTimeKey) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: endTimeKey)
        }
    }
}




struct NoteBox: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("The current version of the app only allows for one universal schedule for all contacts.")
                .foregroundColor(.gray)
                .padding(.horizontal)

            Text("Changes made here are applied to all selected contacts.")
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
        .padding()
        .background(Color.yellow.opacity(0.2))
        .cornerRadius(10)
        .padding()
    }
}

struct CallFrequencyPicker: View {
    @Binding var callFrequency: CallFrequency

    var body: some View {
        HStack {
            Text("Call Frequency")
                .font(.headline)
                .padding(.leading)

            Picker("", selection: $callFrequency) {
                ForEach(CallFrequency.allCases, id: \.self) { frequency in
                    Text(frequency.rawValue.capitalized)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.trailing)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}


struct DaysForCalls: View {
    @Binding var selectedDays: [DayOfWeek]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Days Available for Calls")
                .font(.headline)
                .padding(.leading)

            HStack {
                ForEach(DayOfWeek.allCases, id: \.self) { day in
                    DayButton(day: day, selectedDays: $selectedDays)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct DayButton: View {
    let day: DayOfWeek
    @Binding var selectedDays: [DayOfWeek]

    var body: some View {
        Button(action: {
            if selectedDays.contains(day) {
                selectedDays.removeAll { $0 == day }
            } else {
                selectedDays.append(day)
            }
        }) {
            Text(String(day.rawValue.first!))
                .foregroundColor(selectedDays.contains(day) ? .white : .black)
                .padding(8)
                .background(selectedDays.contains(day) ? Color.blue : Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        }
    }
}

struct TimePicker: View {
    let title: String
    @Binding var selectedTime: Date

    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .frame(height: 30)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

enum CallFrequency: String, CaseIterable {
    case daily
    case weekly
    case everyOtherWeek = "Every Other Week"
    case monthly
    case biMonthly = "Bi-Monthly"
    case quarterly
}

enum DayOfWeek: String, CaseIterable {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

struct SchedulingPage_Previews: PreviewProvider {
    static var previews: some View {
        editSchedule()
    }
}

