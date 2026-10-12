//
//  AddSubjectView.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/12/26.
//
import SwiftUI
import SwiftData

struct AddSubjectView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss

    let semester: Semester

    @State private var name = ""
    @State private var code = ""
    @State private var instructor = ""

    private var canSave: Bool {
        !name.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Subject Information") {
                    TextField("Name", text: $name)
                    TextField("Course Code", text: $code)
                    TextField("Instructor", text: $instructor)
                }

                Section("Semester") {
                    Text(semester.name)
                }
            }
            .navigationTitle("New Subject")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveSubject()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }

    private func saveSubject() {
        let subject = Subject(
            name: name.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            code: code.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            instructor: instructor.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            semester: semester
        )

        modelContext.insert(subject)
        dismiss()
    }
}
