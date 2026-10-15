//
//  SubjectFormView.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/12/26.
//
import SwiftUI
import SwiftData

struct SubjectFormView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss

    private let subject: Subject?
    private let semester: Semester

    @State private var name: String
    @State private var code: String
    @State private var instructor: String

    @State private var saveError: String?

    // CREATE mode
    init(semester: Semester) {
        self.subject = nil
        self.semester = semester

        _name = State(initialValue: "")
        _code = State(initialValue: "")
        _instructor = State(initialValue: "")
    }

    // EDIT mode
    init(subject: Subject) {
        self.subject = subject
        self.semester = subject.semester!

        _name = State(initialValue: subject.name)
        _code = State(initialValue: subject.code)
        _instructor = State(initialValue: subject.instructor)
    }

    private var isEditing: Bool {
        subject != nil
    }

    private var canSave: Bool {
        !name.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Course Information") {
                    TextField("Subject Name", text: $name)
                        .textInputAutocapitalization(.words)

                    TextField("Course Code", text: $code)
                        .textInputAutocapitalization(.characters)

                    TextField("Instructor", text: $instructor)
                        .textInputAutocapitalization(.words)
                }

                Section("Semester") {
                    LabeledContent(
                        "Semester",
                        value: semester.name
                    )
                }
            }
            .navigationTitle(
                isEditing ? "Edit Subject" : "New Subject"
            )
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
            .alert(
                "Unable to Save",
                isPresented: Binding(
                    get: { saveError != nil },
                    set: { if !$0 { saveError = nil } }
                )
            ) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(saveError ?? "An unknown error occurred.")
            }
        }
    }

    private func saveSubject() {
        let cleanName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let cleanCode = code.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let cleanInstructor = instructor.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if let subject {
            // UPDATE
            subject.name = cleanName
            subject.code = cleanCode
            subject.instructor = cleanInstructor
        } else {
            // CREATE
            let newSubject = Subject(
                name: cleanName,
                code: cleanCode,
                instructor: cleanInstructor,
                semester: semester
            )

            modelContext.insert(newSubject)
        }

        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
            saveError = error.localizedDescription
        }
    }
}
