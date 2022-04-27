//
//  ListViewViewModel.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 27/04/22.
//

import Foundation
import RxSwift
import RxCocoa

class ThoughtViewViewModel {
  private var texts: Texts
  
  init(texts: Texts) {
    self.texts = texts
  }
  
  var textTitle: String {
    return texts.textTitle!
  }
  
  var textDescription: String {
    return texts.textDescription!
  }
  
}
