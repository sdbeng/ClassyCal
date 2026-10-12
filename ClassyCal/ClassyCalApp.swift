//
//  ClassyCalApp.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/11/26.
//

import SwiftUI
import SwiftData

@main
struct ClassyCalApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
        .modelContainer(
            for: [
                Semester.self,
                Subject.self
            ]
        )
    }
}
