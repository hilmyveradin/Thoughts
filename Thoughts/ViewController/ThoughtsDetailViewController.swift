//
//  ThoughtsDetailViewController.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 04/10/22.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

final class ThoughtsDetailViewController: UIViewController {
    
    //MARK: - PROPERTIES
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.text = "foo"
        return lbl
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.text = "bar"
        return lbl
    }()
    
    let model: Texts
    
    let viewModel: ThoughtsDetailViewModel
    let disposeBag = DisposeBag()
    
    //MARK: - INITIALIZATION
    init(viewModel: ThoughtsDetailViewModel = ThoughtsDetailViewModel(), model: Texts) {
        self.model = model
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupView()
    }
    
    //MARK: - PRIVATE
    private func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        titleLabel.anchor(width: 200,
                          centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        descriptionLabel.anchor(top: titleLabel.safeAreaLayoutGuide.bottomAnchor, paddingTop: 30,
                                width: 200,
                                centerX: view.centerXAnchor)
        titleLabel.text = model.textTitle!
        descriptionLabel.text = model.textDescription!
    }
}
