//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Isaad Khan on 2023-04-03.
//

import Foundation

struct TodoItem: Identifiable {
    var id: Int
    var description: String
    var completed: Bool
}

var existingToDoItems = [

    TodoItem(id: 1, description: "Study for Physics quiz", completed: false)
    
    ,
    
    TodoItem(id: 2, description: "Finish Computer Science assignment", completed: true)
    
    ,
    
    TodoItem(id: 3, description: "Go for a run", completed: false)
]
