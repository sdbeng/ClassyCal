//
//  ScheduleView.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/11/26.
//
import SwiftUI

struct ScheduleView: View {
    var body: some View {
        ContentUnavailableView(
            "Weekly Schedule",
            systemImage: "calendar",
            description: Text(
                "Your weekly class schedule will appear here."
            )
        )
        .navigationTitle("Schedule")
    }
}
