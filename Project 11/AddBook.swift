//
//  AddBook.swift
//  Project 11
//
//  Created by Makwan BK on 1/24/20.
//  Copyright © 2020 Makwan BK. All rights reserved.
//

import SwiftUI

struct AddBook: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        
                        try? self.moc.save()
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            .disabled(makeThingsPerfect() == false)
            
            }.navigationTitle("Add Book")
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
            })
        }
    }
    
    func makeThingsPerfect() -> Bool {
        if genre == "" || title == "" || title == " " || author == "" || author == " " {
            return false
        }
        return true
    }
    
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}
