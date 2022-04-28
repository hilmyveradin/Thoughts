//
//  ThoughtListViewModel.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 27/04/22.
//

import Foundation
import RxSwift
import RxCocoa

class ThoughtListViewModel {
  private var texts = BehaviorRelay<[Texts]>(value: [])
//  private var thoughtsManagerCoreData = ThoughtsManagerCoreData()
  private var disposeBag = DisposeBag()
  
  static let shared = ThoughtListViewModel()
  
  init() {
    fetchTextsAndUpdateObservableTodos()
    print("initialized")
  }
  
  func getTexts() -> BehaviorRelay<[Texts]> {
    print("View model: get texts")
    return texts
  }
  
  func fetchTextsAndUpdateObservableTodos() {
    print("View Model: fetch texts")
    ThoughtsManagerCoreData.shared.fetchObservableData()
      .map({ $0 })
      .subscribe(onNext : { (todos) in
        self.texts.accept(todos)
      })
      .disposed(by: disposeBag)
  }
  
  public func removeTodo(withIndex index: Int) {
    ThoughtsManagerCoreData.shared.removeTexts(withIndex: index)
  }
  
  
  
}
