//
//  SubmitView.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import SwiftUI

struct SubmitView: View {
    @StateObject var model: SubmitModel
    var onButtonTap: (() -> Void)?

    var body: some View {
        VStack {
            DatePicker("Select Date and Time", selection: $model.selectedDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Text("Selected Date and Time:")
            Text("\(model.selectedDate)")
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
        .alert(isPresented: $model.showAlert) {
            Alert(title: Text("Invalid Date"), message: Text("The selected date and time cannot be in the future."), dismissButton: .default(Text("OK")))
        }
    }

    private func handleSubmit() {
        onButtonTap?()
    }
}

#Preview {
    SubmitView(model: SubmitModel())
}
