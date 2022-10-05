//
//  ThoughtsCellViewModel.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 05/10/22.
//

import Foundation

final class ThoughtsCellViewModel {
    
    private var texts: Texts
    
    init(texts: Texts) {
      self.texts = texts
    }
    
    var title: String {
        return texts.textTitle ?? ""
    }
    
    var description: String {
        return texts.textDescription ?? ""
    }
}
