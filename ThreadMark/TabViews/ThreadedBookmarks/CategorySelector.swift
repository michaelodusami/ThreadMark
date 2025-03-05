//
//  CategorySelector.swift
//  ThreadMark
//
//  Created by Tise on 3/5/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI



struct CategorySelector: View {

    @Binding var selectedCategory: String?
    // users can assign a category (predefined for now -- tech, productivity, science, home, personal, health, video, other)
    var body: some View {

        Picker("Category", selection: $selectedCategory) {
            ForEach(bookmarkCategories, id: \.self) { aCat in
                Text(aCat.capitalized).tag(aCat as String?)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }  // MARK: Picker ends here
        .pickerStyle(MenuPickerStyle())

    }
}

#Preview {
    CategorySelector(selectedCategory: .constant(bookmarkCategories[0]))
}
