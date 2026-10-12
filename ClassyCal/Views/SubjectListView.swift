//
//  SubjectListView.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/11/26.
//
import SwiftUI
import SwiftData

struct SubjectListView: View {
    @Environment(\.modelContext) //gives us access to persistence
    private var modelContext

    @Query(sort: \Semester.startDate, order: .reverse) //keeps the fetched model collections reactive
    private var semesters: [Semester]

    @Query(sort: \Subject.name)
    private var subjects: [Subject]
    //track local UI selections and sheet presentation
    @State private var selectedSemesterID: UUID?
    @State private var showingAddSemester = false
    @State private var showingAddSubject = false

    private var selectedSemester: Semester? {
        semesters.first {
            $0.id == selectedSemesterID
        }
    }

    private var filteredSubjects: [Subject] {
        guard let selectedSemester else { return [] }

        return subjects.filter {
            $0.semester?.id == selectedSemester.id
        }
    }
    
    private var subjectsSection: some View {
        Section("Subjects") {
            if selectedSemester == nil {
                ContentUnavailableView(
                    "No Semester Selected",
                    systemImage: "graduationcap",
                    description: Text("Create or select a semester to begin.")
                )
            } else if filteredSubjects.isEmpty {
                ContentUnavailableView(
                    "No Subjects",
                    systemImage: "books.vertical",
                    description: Text("Add your first college subject.")
                )
            } else {
                ForEach(filteredSubjects) { subject in
                    VStack(
                        alignment: .leading,
                        spacing: 4
                    ) {
                        Text(subject.name)
                            .font(.headline)

                        Text(subject.code)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }

    var body: some View {
        List {
            if !semesters.isEmpty {
                Section("Semester") {
                    Picker(
                        "Active Semester",
                        selection: $selectedSemesterID
                    ) {
                        Text("Select a semester")
                            .tag(nil as UUID?)

                        ForEach(semesters) { semester in
                            Text(semester.name)
                                .tag(Optional(semester.id))
                        }
                    }
                }
            }
           subjectsSection //extracted into own block, fixes compiler not able to calc complex conditionals, closure
        }
        .navigationTitle("Subjects")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showingAddSemester = true
                } label: {
                    Image(systemName: "calendar.badge.plus")
                }
                .accessibilityLabel("Add Semester")
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddSubject = true
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(selectedSemester == nil)
                .accessibilityLabel("Add Subject")
            }
        }
        .sheet(isPresented: $showingAddSemester) {
            AddSemesterView()
        }
        .sheet(isPresented: $showingAddSubject) {
            if let selectedSemester {
                AddSubjectView(semester: selectedSemester)
            }
        }
        .onAppear {
            selectDefaultSemester()
        }
        .onChange(of: semesters.map(\.id)) {
            selectDefaultSemester()
        }
    }

    private func selectDefaultSemester() {
        if selectedSemester == nil {
            selectedSemesterID = semesters.first?.id
        }
    }
}
