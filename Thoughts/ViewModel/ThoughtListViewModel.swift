//
//  ThoughtListViewModel.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 27/04/22.
//

import Foundation
import RxSwift
import RxCocoa

//TODO: Analyze this VM Functionality
class ThoughtListViewModel {
    
    private var texts = BehaviorRelay<[Texts]>(value: [])
    private var disposeBag = DisposeBag()
    
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
    
    //MARK: - Private
    private func fetchTextsAndUpdateObservableTodos() {
        print("View Model: fetch texts")
        // Model Interaction
        ThoughtsManagerCoreData.shared.fetchObservableData()
            .map({ $0 })
            .subscribe(onNext: { (todos) in
                self.texts.accept(todos)
            })
            .disposed(by: disposeBag)
    }
}
