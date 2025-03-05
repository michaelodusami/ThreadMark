//
//  ThreadMarkApp.swift
//  ThreadMark
//
//  Created by Tise on 3/5/25.
//

import SwiftUI

@main
struct ThreadMarkApp: App {
    let bookmarkPersistenceController = BookmarkManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, bookmarkPersistenceController.container.viewContext)
        }
    }
}
