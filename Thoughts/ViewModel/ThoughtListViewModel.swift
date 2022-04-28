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
  private var thoughtsManagerCoreData = ThoughtsManagerCoreData()
  private var disposeBag = DisposeBag()
  
  init() {
    fetchTextsAndUpdateObservableTodos()
  }
  
  func getTexts() -> BehaviorRelay<[Texts]> {
    return texts
  }
  
  func fetchTextsAndUpdateObservableTodos() {
    thoughtsManagerCoreData.fetchObservableData()
      .map({ $0 })
      .subscribe(onNext : { (todos) in
        self.texts.accept(todos)
      })
      .disposed(by: disposeBag)
  }
  
  func saveThought(titleText: String, descText: String, date: Date) {
    thoughtsManagerCoreData.saveThought(titleText: titleText, descText: descText, date: date)
    
  }
  
}
