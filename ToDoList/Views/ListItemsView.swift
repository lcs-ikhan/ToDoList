//
//  ListItemsView.swift
//  ToDoList
//
//  Created by Isaad Khan on 2023-04-17.
//

import Blackbird
import SwiftUI

struct ListItemsView: View {
    
    // MARK: Stored properties
    
    // Needed to query database
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    // The list of items to be completed
    @BlackbirdLiveModels var todoItems: Blackbird.LiveResults<TodoItem>
    
    
    var body: some View {
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
    }
    
    
    // MARK: Initializer(s)
    init(filteredOn searchText: String) {
        
        
        // Initialize the live model
        _todoItems = BlackbirdLiveModels({ db in
            try await TodoItem.read(from: db,
        sqlWhere: "description LIKE ?", "%\(searchText)%")
        })
        
    }
    
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

struct ListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemsView(filteredOn: "testing")
        // Make the database available to all other views through the environment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
