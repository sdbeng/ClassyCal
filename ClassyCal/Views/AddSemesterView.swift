//
//  AddSemesterView.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/12/26.
//
import SwiftUI
import SwiftData

struct AddSemesterView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss

    @State private var name = ""
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(
        byAdding: .month,
        value: 4,
        to: .now
    ) ?? .now

    private var canSave: Bool {
        !name.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty && endDate >= startDate
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Semester name", text: $name)

                DatePicker(
                    "Start Date",
                    selection: $startDate,
                    displayedComponents: .date
                )

                DatePicker(
                    "End Date",
                    selection: $endDate,
                    in: startDate...,
                    displayedComponents: .date
                )
            }
            .navigationTitle("New Semester")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveSemester()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }

    private func saveSemester() {
        let semester = Semester(
            name: name.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            startDate: startDate,
            endDate: endDate
        )

        modelContext.insert(semester)
        dismiss()
    }
}
