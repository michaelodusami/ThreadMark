//
//  BookmarkManager.swift
//  ThreadMark
//
//  Created by Tise on 3/5/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import CoreData
import Foundation
import SwiftUI

let bookmarkCategories = [
    "tech", "productivity", "science", "home", "personal", "personal", "health",
    "other",
]

@Observable
class BookmarkManager {

    static let shared = BookmarkManager()
    let container: NSPersistentContainer
    // var bookmarks: [Bookmark] = []

    @MainActor
    static let preview: BookmarkManager = {
        let result = BookmarkManager(inMemory: true)
        let viewContext = result.container.viewContext

        for i in 0..<10 {
            let newBookmark = Bookmark(context: viewContext)
            newBookmark.id = UUID()
            newBookmark.content =
                "Example Bookmark #\(i + 1) - SwiftUI & CoreData"
            newBookmark.category = bookmarkCategories.randomElement() ?? "tech"
            newBookmark.createdAt = Date().addingTimeInterval(
                TimeInterval(-i * 86400))
            newBookmark.source = "https://example.com/bookmark\(i + 1)"
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ThreadMark")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(
                fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

}

func exampleBookmark() -> Bookmark {
    let context = BookmarkManager.shared.container.viewContext
    let bookmark = Bookmark(context: context)
    bookmark.id = UUID()
    bookmark.content = "This is an example bookmark about SwiftUI and CoreData."
    bookmark.category = "Tech"
    bookmark.createdAt = Date()
    bookmark.source = "https://developer.apple.com/documentation/swiftui"
    return bookmark
}
