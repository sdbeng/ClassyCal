//
//  SubjectPersistenceTests.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/12/26.
//SwiftData persistence tests
//This test uses an in-memory container, so it wont' modify my app's actual database
import Foundation
import SwiftData
import Testing

@testable import ClassyCal

private func makeTestContainer() throws -> ModelContainer {
    let schema = Schema([
        Semester.self,
        Subject.self
    ])
    let configuration = ModelConfiguration(
        schema: schema,
        isStoredInMemoryOnly: true
    )
    return try ModelContainer(for: schema, configurations: [configuration])
}

@MainActor
struct SubjectPersistenceTests {
    
    @Test func `subjectBelongsToSemester`() async throws {
        let schema = Schema([
            Semester.self,
            Subject.self
        ])
        
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        
        let container = try ModelContainer(for: schema, configurations: [configuration])
        
        let context = container.mainContext
        
        let semester = Semester(
                    name: "Fall 2026",
                    startDate: .now,
                    endDate: .now.addingTimeInterval(
                        60 * 60 * 24 * 120
                    )
                )

                context.insert(semester)

                let subject = Subject(
                    name: "Computer Science",
                    code: "CS101",
                    semester: semester
                )

                context.insert(subject)
                try context.save()
        
                let savedSubjects = try context.fetch(
                    FetchDescriptor<Subject>()
                )
        #expect(savedSubjects.count == 1)
        #expect(savedSubjects.first?.name == "Computer Science")
        #expect(savedSubjects.first?.semester?.name == "Fall 2026")
    }
    
    @Test
    func updatingSubjectPersistsChanges() throws {
        let container = try makeTestContainer()
        let context = container.mainContext

        let subject = Subject(
            name: "Math",
            code: "MATH101"
        )

        context.insert(subject)
        try context.save()

        subject.name = "Advanced Math"
        try context.save()

        let saved = try context.fetch(
            FetchDescriptor<Subject>()
        )

        #expect(saved.count == 1)
        #expect(saved.first?.name == "Advanced Math")
    }
}
