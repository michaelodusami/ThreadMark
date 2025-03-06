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

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedCategory: String? = bookmarkCategories.first
    @State private var source: String = ""
    @State private var tagsInput: String = ""

    var body: some View {

        NavigationStack {
            Form {

                Section(header: Text("Title of bookmark")) {
                    TextField("Enter the title of your bookmark", text: $title)
                }

                Section(header: Text("Bookmark Content")) {
                    TextEditor(text: $content)
                        .frame(minHeight: 100)
                        .font(.body)
                        .minimumScaleFactor(0.5)
                       

                }

                Section(header: Text("Category")) {
                    CategorySelector(selectedCategory: $selectedCategory)
                }

                Section(header: Text("Source (Optional)")) {
                    TextField("Enter source", text: $source)
                }

                Section(header: Text("Tags (Optional, comma seperated)")) {
                    TextField(
                        "e.g., SwiftUI, Leadership, Startups", text: $tagsInput)
                }
            }
            .navigationTitle("Add Bookmark")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    addBookmark()
                })
        }
    }

    private func addBookmark() {
        guard let category = selectedCategory, !content.isEmpty else { return }
        let newBookmark = Bookmark(context: viewContext)
        newBookmark.id = UUID()
        newBookmark.title = title
        newBookmark.content = content
        newBookmark.category = category
        newBookmark.createdAt = Date()
        newBookmark.source = source.isEmpty ? nil : source

        let tagsArr = tagsInput.split(separator: ".").map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }.filter { !$0.isEmpty }
        newBookmark.tags = tagsArr

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
        .environment(
            \.managedObjectContext,
            BookmarkManager.preview.container.viewContext)
}
