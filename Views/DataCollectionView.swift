//
//  DataCollectionView.swift
//  Lab Data Management
//
//  Created by William Thompson on 11/19/23.
//

import SwiftUI

struct DataCollectionView: View {
    @Binding var dataCollectionFlag: Bool
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var events: [(String, TimeInterval)] = []
    @State private var isCustomPopupPresented = false
    @State private var customEventText = ""
    @State private var customEventTimeStamp : TimeInterval = 0
    @State private var latestEvents: [String] = []

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(formattedTime)
                    .padding()
                    .font(.largeTitle)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3.5)
            }
            
            List(latestEvents, id: \.self) { event in
                            Text(event)
                        }
                        .listStyle(InsetGroupedListStyle())
            
            
            VStack(spacing: 10) {
                HStack {
                    EventButton(event: "Enter Body", logEvent: logEvent)

                    EventButton(event: "Exit Body", logEvent: logEvent)
                }
                HStack {
                    EventButton(event: "Manual Aspiration Start", logEvent: logEvent)

                    EventButton(event: "Manual Aspiration End", logEvent: logEvent)
                }
                HStack {
                    EventButton(event: "Charged Aspiration", logEvent: logEvent)

                    EventButton(event: "Wall Latch", logEvent: logEvent)
                }
                HStack {
                    EventButton(event: "Blood Return", logEvent: logEvent)

                    EventButton(event: "Contrast Injection", logEvent: logEvent)
                }
                
                EventButton(event: "Custom", logEvent: setCustomTime)
                                .alert("Enter custom event:", isPresented: $isCustomPopupPresented) {
                                    TextField("Custom Event", text: $customEventText)
                                    Button("OK") {
                                        isCustomPopupPresented.toggle()
                                        logEventCustom(event: customEventText, time: customEventTimeStamp)
                                    }
                                }
                                .padding()
                
                Button(action: {
                                undoLastEvent()
                            }) {
                                Text("Undo")
                                    .frame(width: 200, height: 50)
                                    .background(Color.orange)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(5)
                            }
                            .padding()
            }
            
//            Spacer()
            
            Button(action: {
                print("stop button clicked")
                stopDataCollection()
                saveToCSV()
            }) {
                Text("Stop")
                    .frame(width: 400, height: 100, alignment: .center)
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(5)
        }
        .padding()
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        print("Timer started")
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            elapsedTime += 0.01
        }
    }

    private func stopTimer() {
        print("Timer stopped")
        timer?.invalidate()
    }

    private var formattedTime: String {
        let hours = Int(elapsedTime) / 3600
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "Time:  %02d:%02d:%02d", hours, minutes, seconds)
    }

    private func stopDataCollection() {
        stopTimer()
        dataCollectionFlag = true
    }
    
    private func logEventCustom(event: String, time: TimeInterval) {
        isCustomPopupPresented.toggle()
        events.append((event, time))
        updateLatestEvents()
        customEventText = ""
    }
    
    private func setCustomTime(event: String) {
        isCustomPopupPresented.toggle()
        customEventTimeStamp = elapsedTime
    }
    
    private func logEvent(event: String) {
        let elapsedTimeInterval = elapsedTime
        events.append((event, elapsedTimeInterval))
        updateLatestEvents()
    }
    
    private func undoLastEvent() {
            if !events.isEmpty {
                events.removeLast()
                updateLatestEvents()
            }
        }
    
    private func updateLatestEvents() {
            let latestCount = min(events.count, 5)
            latestEvents = events.suffix(latestCount).map { $0.0 }
        }
    
    private func saveToCSV() {
        let fileName = "event_log.csv"
                var csvText = "Event, Timestamp\n"
                let filePath = getDocumentsDirectory().appendingPathComponent(fileName)

                // Add events to CSV
                for event in events {
                    let line = "\(event.0),\(event.1)\n"
                    csvText.append(contentsOf: line)
                }
    
        do {
            try csvText.write(to: filePath, atomically: true, encoding: .utf8)
            print("CSV file saved at \(filePath.path)")
            print(csvText)
        } catch {
            print("Error saving CSV file: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }
}
