//
//  BookmarkDetailView.swift
//  ThreadMark
//
//  Created by Tise on 3/5/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI

struct BookmarkDetailView: View {
    let bookmark: Bookmark
    var body: some View {
        VStack(alignment: .leading, spacing: 16)
        {
            Text(bookmark.content ?? "")
                .font(.body)
            
            Text("Category: \(bookmark.category?.capitalized ?? "Not Selected")").font(.subheadline).foregroundStyle(.secondary)
            
            if let source = bookmark.source, !source.isEmpty {
                Text("Source: \(source)")
                    .font(.footnote)
                    .foregroundStyle(.blue)
            }
            Spacer()
        }
        .navigationTitle("Your Bookmark")
    }
}

#Preview {
    BookmarkDetailView(bookmark: exampleBookmark())
}
