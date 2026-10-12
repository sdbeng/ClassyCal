//
//  Subject.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/11/26.
//
import Foundation
import SwiftData

@Model
final class Subject {
    @Attribute(.unique)
    var id: UUID
    var name: String
    
    var code: String
    var instructor: String
    var colorHex: String
    
    var semester: Semester?
    
    init(name: String, code: String, instructor: String = "", colorHex: String="#64748B", semester: Semester? = nil) {
        self.id = UUID()
        self.name = name
        self.code = code
        self.instructor = instructor
        self.colorHex = colorHex
        self.semester = semester
    }
    
}
