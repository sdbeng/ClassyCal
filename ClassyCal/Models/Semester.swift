//
//  Semester.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/11/26.
//

import Foundation
import SwiftData

@Model
final class Semester {
    @Attribute(.unique)
    var id: UUID

    var name: String
    var startDate: Date
    var endDate: Date

    @Relationship(deleteRule: .cascade)
    var subjects: [Subject] = []

    init(
        name: String,
        startDate: Date,
        endDate: Date
    ) {
        self.id = UUID()
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
    }
}
