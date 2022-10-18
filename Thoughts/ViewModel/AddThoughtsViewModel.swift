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
    typealias SaveThoughts =  (_ titleText: String, _ descText: String, _ date: Date) -> Void
    //MARK: - PROPERTIES
    let saveThoughts: SaveThoughts
    
    init(saveThoughts: @escaping SaveThoughts = ThoughtsManagerCoreData.shared.saveThought(titleText:descText:date:)) {
        // pas init bisa di configure sesuai kebutuhan
        self.saveThoughts = saveThoughts
    }
    
    func checkIsTextValid(_ titleText: String, _ descriptionText: String) -> Bool {
        
        guard titleText != "" && descriptionText != "" else {
            return false
        }
        
        let date = Date()
        self.saveThoughts(titleText, descriptionText, date)
        
        return true
    }
}
