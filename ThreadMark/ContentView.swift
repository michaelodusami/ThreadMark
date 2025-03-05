//
//  ContentView.swift
//  ThreadMark
//
//  Created by Tise on 3/5/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            Tab("Bookmarks", systemImage: "bookmark.fill"){
                ThreadedBookmarksTabView()
            }
        }
    }

   
}


#Preview {
    ContentView().environment(\.managedObjectContext, BookmarkManager.preview.container.viewContext)
}
