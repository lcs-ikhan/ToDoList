//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Isaad Khan on 2023-04-03.
//

import Blackbird
import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                // Make the databse available to all other views through the environment
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
