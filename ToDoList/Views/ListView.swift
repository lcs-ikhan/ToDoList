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
    
    // Access the connection to the database (needed to add a new record)
    @Environment(\.blackbirdDatabase) var db:
    Blackbird.Database?
    
    // The list of items to be completed
    @BlackbirdLiveModels({ db in
        try await TodoItem.read(from: db)
    }) var todoItems
    
    // The item currently being added
    @State var newItemDescription: String = ""
    
    
    // The current search text
    @State var searchText = ""
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                    
                    TextField("Enter a to-do item", text: $newItemDescription)
                    
                    Button(action: {
                        Task{
                            // Write to database
                            try await db!.transaction { core in
                                try core.query("INSERT INTO TodoItem (description) VALUES (?)", newItemDescription)
                            }
                            
                            // Clear the input field
                            newItemDescription = ""
                        }
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                    
                }
                .padding(20)
                List{
                    
                    ForEach(todoItems.results) { currentItem in
                        
                        Label(title: {
                            Text(currentItem.description)
                        }, icon: {
                            if currentItem.completed == true {
                                Image(systemName : "checkmark.circle")
                            } else {
                                Image(systemName: "circle")
                            }
                        })
                        .onTapGesture{
                            Task{
                                try await db!.transaction { core in
                                    // Change the status for this person to the opposite of its current value
                                    try core.query("UPDATE TodoItem Set completed = (?) WHERE id = (?)",
                                                   !currentItem.completed,
                                                   currentItem.id)
                                    
                                }
                                
                            }
                        }
                    }
                    .onDelete(perform: removeRows)
                }
                .searchable(text: $searchText)
                .navigationTitle("To do")
            }
            
        }
    }
    
    // MARK: Functions
    func removeRows(at offsets: IndexSet) {
        
        Task{
            
            try await db!.transaction { core in
                
                // Get the ID of the item to be deleted
                var idList = ""
                for offset in offsets {
                    idList += "\(todoItems.results[offset].id),"
                }
                
                // Remove the final comma
                print("Before removing comma: \(idList)")
                idList.removeLast()
                print("After removing comma: \(idList)")

                // Delete the row(s) from the database
                try core.query("DELETE FROM TodoItem WHERE id IN (?)", idList)
            }
        }
        
    }
}
    
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

