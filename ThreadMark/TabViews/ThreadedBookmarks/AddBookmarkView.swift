//
//  AddBookmarkView.swift
//  ThreadMark
//
//  Created by Tise on 3/5/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI

struct AddBookmarkView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var content: String = ""
    @State private var selectedCategory: String? = bookmarkCategories.first
    @State private var source: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Bookmark Content")){
                    TextField("Enter text, URL, or note", text: $content)
                }
                
                Section(header: Text("Category")){
                    CategorySelector(selectedCategory: $selectedCategory)
                }
                
                Section(header: Text("Source (Optional)")){
                    TextField("Enter source", text: $source)
                }
            }
            .navigationTitle("Add Bookmark")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            }, trailing: Button("Save"){
                addBookmark()
            })
        }
    }
    
    private func addBookmark() {
            guard let category = selectedCategory, !content.isEmpty else { return }
            let newBookmark = Bookmark(context: viewContext)
            newBookmark.id = UUID()
            newBookmark.content = content
            newBookmark.category = category
            newBookmark.createdAt = Date()
            newBookmark.source = source.isEmpty ? nil : source
            
            do {
                try viewContext.save()
                dismiss()
            } catch {
                print("Error saving bookmark: \(error)")
            }
        }
}

#Preview {
    AddBookmarkView()
        .environment(\.managedObjectContext, BookmarkManager.preview.container.viewContext)
}
