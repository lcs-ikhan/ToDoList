//
//  ContentView.swift
//  ToDoList
//
//  Created by Isaad Khan on 2023-04-03.
//

import Blackbird
import SwiftUI

struct ListView: View {
    // MARK: Stored properties
    
    // The list of items to be completed
    @BlackbirdLiveModels({ db in
        try await TodoItem.read(from: db)
    }) var todoItems
    
    // The item currently being added
    @State var newItemDescription: String = ""
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                    
                    TextField("Enter a to-do item", text: $newItemDescription)

                    Button(action: {
//                        // Get last todo item id
//                        let lastId = todoItems.last!.id
//
//                        // Create new todo item id
//                        let newId = lastId + 1
//
//                        //Create the new todo item
//                        let newTodoItem = TodoItem(id: newId,
//                                                   description:newItemDescription,
//                                                   completed: false)
//
//                    // Add the new to-do item to the list
//                        todoItems.append(newTodoItem)
//
//                    // Clear the input field
//                    newItemDescription = ""
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                    
                }
                .padding(20)
                
            List(todoItems.results) { currentItem in
                    
                    Label(title: {
                        Text(currentItem.description)
                    }, icon: {
                        if currentItem.completed == true {
                            Image(systemName : "checkmark.circle")
                        } else {
                            Image(systemName: "circle")
                        }
                    })
                    
                }
            }
            .navigationTitle("To do")
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
