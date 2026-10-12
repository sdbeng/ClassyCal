//
//  RootTabView.swift
//  ClassyCal
//
//  Created by Sergio Daniel Barrera on 10/11/26.
//
import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            Tab("Today", systemImage: "house") {
                NavigationStack {
                    TodayView()
                }
            }

            Tab("Subjects", systemImage: "books.vertical") {
                NavigationStack {
                    SubjectListView()
                }
            }

            Tab("Schedule", systemImage: "calendar") {
                NavigationStack {
                    ScheduleView()
                }
            }
        }
    }
}
