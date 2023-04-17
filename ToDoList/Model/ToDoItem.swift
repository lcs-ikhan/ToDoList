//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Isaad Khan on 2023-04-03.
//

import Blackbird
import Foundation

struct TodoItem: BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var description: String
    @BlackbirdColumn var completed: Bool
}

