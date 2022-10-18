//
//  ThoughtsDetailViewModel.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 04/10/22.
//

import Foundation
import RxCocoa
import RxSwift

final class ThoughtsDetailViewModel {
    
    var model: Texts
    
    var title: Driver<String>
    var description: Driver<String>
    
    var titlePublisher = PublishSubject<String>()
    var descriptionPublisher = PublishSubject<String>()
    
    init(model: Texts) {
        self.model = model
        self.title = titlePublisher.asDriver(onErrorJustReturn: "")
        self.description = descriptionPublisher.asDriver(onErrorJustReturn: "")
    }
    
    func populateData() {
        titlePublisher.onNext(model.textTitle ?? "")
        descriptionPublisher.onNext(model.textDescription ?? "")
    }
    
}
