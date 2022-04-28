//
//  AddThoughtsViewModel.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 28/04/22.
//

import Foundation

class AddThoughtsViewModel {
  func saveThought(titleText: String, descText: String, date: Date) {
    ThoughtsManagerCoreData.shared.saveThought(titleText: titleText, descText: descText, date: date)
  }
}
