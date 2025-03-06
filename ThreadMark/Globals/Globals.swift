//
//  Globals.swift
//  ThreadMark
//
//  Created by Tise on 3/5/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import Foundation


let bookmarkCategories = [
    "tech", "productivity", "science", "home", "personal", "personal", "health",
    "other",
]

/// Returns an example bookmark to use
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
