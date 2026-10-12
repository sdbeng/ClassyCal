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
}

