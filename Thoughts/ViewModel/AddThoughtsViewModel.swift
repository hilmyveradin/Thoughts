//
//  AddThoughtListViewModel.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 02/10/22.
//

import Foundation
import RxSwift
import RxCocoa

final class AddThoughtListViewModel {
    
    //MARK: - PROPERTIES
    private let disposeBag = DisposeBag()
    private var texts = BehaviorRelay<[Texts]>(value: [])
    
    init() {
        
    }
    
    func checkIsTextValid(_ titleText: String, _ descriptionText: String) -> Bool {
        
        guard titleText != "" && descriptionText != "" else {
            return false
        }
        
        let date = Date()
        ThoughtsManagerCoreData.shared.saveThought(titleText: titleText, descText: descriptionText, date: date)
        
        return true
    }
}
