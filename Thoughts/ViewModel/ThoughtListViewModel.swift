//
//  ThoughtListViewModel.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 27/04/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol ThoughtListViewModelType: AnyObject {
    func transform(_ input: ThoughtListViewModel.Input) -> ThoughtListViewModel.Output
}

final class ThoughtListViewModel: ThoughtListViewModelType {
    
    // MARK: Input / Output
    struct Input {
        let textInput: Observable<Void>
    }
    
    struct Output {
        let textDriver: Driver<String>
    }
    
    func transform(_ input: Input) -> Output {
        let textDriver = input.textInput.asDriverOnErrorJustComplete()
        
        return Output(textDriver: textDriver)
    }
    
    private var texts = BehaviorRelay<[Texts]>(value: [])
    private let disposeBag = DisposeBag()
    
    init() {
        fetchTextsAndUpdateObservableTodos()
        print("initialized")
    }
    
    func getTexts() -> BehaviorRelay<[Texts]> {
        print("View model: get texts")
        return texts
    }
    
    func removeTodo(withIndex index: Int) {
        ThoughtsManagerCoreData.shared.removeTexts(withIndex: index)
    }
    
    func viewModelForText(at index: Int) -> ThoughtsCellViewModel? {
      guard index < texts.value.count else {
        return nil
      }
        return ThoughtsCellViewModel(texts: texts.value[index])
    }
    
    //MARK: - Private
    private func fetchTextsAndUpdateObservableTodos() {
        print("View Model: fetch texts")
        ThoughtsManagerCoreData.shared.fetchObservableData()
            .subscribe(onNext: { (todos) in
                self.texts.accept(todos)
            })
            .disposed(by: disposeBag)
    }
}
