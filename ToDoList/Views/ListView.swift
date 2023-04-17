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
               
                ListItemsView(filteredOn: searchText)
                .searchable(text: $searchText)
                .navigationTitle("To do")
            }
            
        }
    }
    
    // MARK: Functions
   
}
    
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

