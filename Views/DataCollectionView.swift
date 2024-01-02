//
//  DataCollectionView.swift
//  Lab Data Management
//
//  Created by William Thompson on 11/19/23.
//

import SwiftUI
import MessageUI
import UniformTypeIdentifiers

struct DataCollectionView: View {
    @Binding var dataCollectionFlag: Bool
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var events: [(String, TimeInterval)] = []
    @State private var isCustomPopupPresented = false
    @State private var customEventText = ""
    @State private var customEventTimeStamp : TimeInterval = 0
    @State private var latestEvents: [String] = []
    @State private var isFilePickerPresented = false
    @State private var fileName = "event_log.csv"
    @State private var undoConfirmation = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(formattedTime)
                    .padding()
                    .font(.largeTitle)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3.5)
            }
            
            VStack(spacing: 10) {
                
                List(latestEvents, id: \.self) { event in
                    Text(event)
                }
                .listStyle(InsetGroupedListStyle())
                .frame(minHeight: 250)
                
                HStack {
                    EventButton(event: "Event 1", logEvent: logEvent)
                    
                    EventButton(event: "Event 2", logEvent: logEvent)
                }
                HStack {
                    EventButton(event: "Event 3", logEvent: logEvent)
                    
                    EventButton(event: "Event 4", logEvent: logEvent)
                }
                HStack {
                    EventButton(event: "Event 5", logEvent: logEvent)
                    
                    EventButton(event: "Event 6", logEvent: logEvent)
                }
                HStack {
                    EventButton(event: "Event 7", logEvent: logEvent)
                    
                    EventButton(event: "Event 8", logEvent: logEvent)
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                Button(action: {
                    undoConfirmation = true
                }) {
                    Text("Undo")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .background(Color.orange)
                .foregroundColor(Color.white)
                .cornerRadius(5)
                .confirmationDialog("Are you sure you want to undo the most recent event? This action cannot be changed.",
                                    isPresented: $undoConfirmation,
                                    actions: {
                    Button("Yes, undo event", role: .destructive) {
                        undoLastEvent()
                    }
                    Button("Cancel", role: .cancel, action: {})
                }){
                }
                
                
                Button(action: {
                    print("stop button clicked")
                    isFilePickerPresented.toggle()
                }) {
                    Text("Stop")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(5)
                .fileExporter(
                            isPresented: $isFilePickerPresented,
                            document: CsvDocument(events: events),
                            contentType: .plainText,
                            defaultFilename: fileName
                ) { result in
                    // Handle export result if needed
                    if case .success = result {
                        print("CSV file exported successfully.")
//                        emailCSV()
                        stopDataCollection()
                    }
                }
                .onAppear {
                    startTimer()
                }
                .onDisappear {
                    stopTimer()
                }
            }
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
}

struct CsvDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.plainText] }
    static var writableContentTypes: [UTType] { [.plainText] }

    var events: [(String, TimeInterval)] = []

    init(events: [(String, TimeInterval)]) {
        self.events = events
    }

    init(configuration: ReadConfiguration) throws {
        // Implement if needed
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let csvText = "Event, Timestamp\n" + events.map { "\($0.0),\($0.1)" }.joined(separator: "\n")
        guard let data = csvText.data(using: .utf8) else {
            throw CocoaError(.fileWriteUnknown)
        }
        return FileWrapper(regularFileWithContents: data)
    }
}

struct MailComposeViewController: UIViewControllerRepresentable {
    
    var toRecipients: [String]
    var mailBody: String
    
    var didFinish: ()->()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposeViewController>) -> MFMailComposeViewController {
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setToRecipients(self.toRecipients)
        mail.setMessageBody(self.mailBody, isHTML: true)
        
        return mail
    }
    
    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        var parent: MailComposeViewController
        
        init(_ mailController: MailComposeViewController) {
            self.parent = mailController
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.didFinish()
            controller.dismiss(animated: true)
        }
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailComposeViewController>) {
        
    }
}


