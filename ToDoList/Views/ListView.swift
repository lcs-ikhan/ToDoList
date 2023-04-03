//
//  ContentView.swift
//  ToDoList
//
//  Created by Isaad Khan on 2023-04-03.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                    
                    TextField("Enter a to-do item", text: Binding.constant(""))
                    
                    Button(action: {
                        
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                    
                }
                .padding(20)
                
                List(existingToDoItems) { currentItem in
                    
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
