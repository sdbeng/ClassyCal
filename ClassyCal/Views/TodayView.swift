//
//  TodayView.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/11/26.
//
import SwiftUI

struct TodayView: View {
    var body: some View {
        ContentUnavailableView(
            "Your Day",
            systemImage: "sun.max",
            description: Text(
                "Upcoming classes and assignments will appear here."
            )
        )
        .navigationTitle("Today")
    }
}
