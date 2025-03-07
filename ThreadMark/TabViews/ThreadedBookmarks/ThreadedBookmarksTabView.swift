//
//  ThreadedBookmarksTabView.swift
//  ThreadMark
//
//  Created by Tise on 3/5/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import CoreData
import SwiftUI

struct ThreadedBookmarksTabView: View {

    /*
     Feature 1: Users can save text snippets, url's, or personal notes as bookmarks with categories i.e:
     * Users can input and save a bookmark (text, url, note)
     * users can assign a category (predefined for now -- tech, productivity, science, home, personal, health, video, other)
     * users can view a list of bookmarks..

     Technical Considerations:
     Bookmark Model (id, content, category, createdAt, tags, source (optional?)

     UI Components:
     * Bookmark List View ( list with saved bookmarks)
     * Bookmark Detail View ( expands to show full content, category and source)
     * Bookmark creation view (users enters text, selects category, and saves -> maybe a sheet for now)
     * Category Selector (Picker w/ text Field Input if User selects 'other')

     Flow:
     - List Of saved Bookmarks
     - Add bookmark Screen
     - Bookmark Detail Screen
     */
    
    /*
     Feature 2:
     Users can assign custom tags and later search or filter by them (e.g., “SwiftUI,” “Leadership,” “Startups”).
     - need to allow users to select tags when adding a bookmark
     - need to allow users to filter by tags on the bookmark list page
     */

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Bookmark.entity(),
        sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)]
    )
    var bookmarks: FetchedResults<Bookmark>

    @State private var showAddBookmark = false
    @State private var searchQuery: String = ""
    
    var filteredBookmarks: [Bookmark] {
        if searchQuery.isEmpty {
            return Array(bookmarks)
        }
        else {
            return bookmarks.filter { bookmark in
                if let tags = bookmark.tags {
                    return tags.contains {$0.localizedCaseInsensitiveContains(searchQuery)}
                }
                return false
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredBookmarks, id: \.id) { aBookmark in
                    NavigationLink(
                        destination: BookmarkDetailView(bookmark: aBookmark)
                    ) {
                        VStack(alignment: .leading) {
                            Text(aBookmark.content ?? "")
                                .lineLimit(1)
                            HStack {
                                Text(aBookmark.category?.capitalized ?? "")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                if let tags = aBookmark.tags, !tags.isEmpty {
                                    Text(tags.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundStyle(.blue)
                                }
                            }
                            
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach {
                        index in
                        let bk = bookmarks[index]
                        deleteBookmark(by: bk.id)
                    }
                }
            }
            .searchable(text: $searchQuery, prompt: "Search by tags")
            .listStyle(.plain)
            .navigationTitle("Bookmarks")
            .navigationBarItems(
                trailing: Button(action: {
                    showAddBookmark.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showAddBookmark) {
                AddBookmarkView()
            }
        }
    }

    func deleteBookmark(by id: UUID?) {
        guard let id = id else {
            return
        }
        
        let fetchRequest: NSFetchRequest<Bookmark> = Bookmark.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if let bookmarkToDelete = result.first {
                viewContext.delete(bookmarkToDelete)
                try viewContext.save()
            }
        }
        catch {
            print("Error deleting bookmark: \(error)")
        }
    }
}

#Preview {
    ThreadedBookmarksTabView()
        .environment(\.managedObjectContext, BookmarkManager.preview.container.viewContext)
        
}
