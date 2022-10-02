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
    // kenapa pake behaviorRelay?
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
        // Kenapa pake map?
            .subscribe(onNext: { (todos) in
                self.texts.accept(todos)
            })
            .disposed(by: disposeBag)
    }
    
    public func removeTodo(withIndex index: Int) {
        ThoughtsManagerCoreData.shared.removeTexts(withIndex: index)
    }
    
}
