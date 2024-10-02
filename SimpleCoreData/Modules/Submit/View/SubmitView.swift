//
//  SubmitView.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import SwiftUI

struct SubmitView: View {
    var onButtonTap: ((Date) -> Void)?
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Text("Selected Date and Time:")
            Text("\(selectedDate, formatter: dateFormatter)")
                .font(.headline)
                .padding()

            Button(action: {
                handleSubmit()
            }) {
                Text("Submit")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
    }

    private func handleSubmit() {
        print("Selected Date and Time: \(selectedDate)")
        onButtonTap?(selectedDate)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    SubmitView()
}
