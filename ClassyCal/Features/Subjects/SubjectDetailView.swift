//
//  SubjectDetailView.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/12/26.
//
import SwiftUI
import SwiftData

struct SubjectDetailView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss

    let subject: Subject

    @State private var showingEdit = false
    @State private var showingDeleteConfirmation = false
    @State private var deleteError: String?

    var body: some View {
        List {
            Section("Course Information") {
                LabeledContent(
                    "Course Code",
                    value: subject.code.isEmpty
                        ? "Not provided"
                        : subject.code
                )

                LabeledContent(
                    "Instructor",
                    value: subject.instructor.isEmpty
                        ? "Not provided"
                        : subject.instructor
                )

                LabeledContent(
                    "Semester",
                    value: subject.semester?.name ?? "Unknown"
                )
            }

            Section("Assignments") {
                ContentUnavailableView(
                    "No Assignments Yet",
                    systemImage: "checklist",
                    description: Text(
                        "Assignments will be added on Day 3."
                    )
                )
            }

            Section("Schedule") {
                ContentUnavailableView(
                    "No Class Sessions Yet",
                    systemImage: "calendar",
                    description: Text(
                        "Class meetings will be added later."
                    )
                )
            }

            Section {
                Button("Delete Subject", role: .destructive) {
                    showingDeleteConfirmation = true
                }
            }
        }
        .navigationTitle(subject.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    showingEdit = true
                }
            }
        }
        .sheet(isPresented: $showingEdit) {
            SubjectFormView(subject: subject)
        }
        .confirmationDialog(
            "Delete Subject?",
            isPresented: $showingDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete Subject", role: .destructive) {
                deleteSubject()
            }
        } message: {
            Text(
                "This subject will be permanently deleted."
            )
        }
        .alert(
            "nable to Delete",
            isPresented: Binding(
                get: {deleteError != nil},
                set: {if !$0 {deleteError = nil}}
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(deleteError ?? "An unknown error occured.")
        }
    }

    private func deleteSubject() {
        modelContext.delete(subject)
        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
            deleteError = error.localizedDescription
        }
        
    }
}
