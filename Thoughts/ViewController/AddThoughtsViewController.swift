//
//  AddThoughtsViewController.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 25/04/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class AddThoughtsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    // MARK: UI COMPONENTS
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Title"
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    private lazy var titleTextField: UITextField = {
        let txtField = UITextField()
        txtField.font = UIFont.systemFont(ofSize: 16)
        txtField.borderStyle = .roundedRect
        txtField.placeholder = "Put your title here"
        return txtField
    }()
    
    private lazy var thoughtsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Thoughts"
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    private lazy var thoughtsTextView: UITextView = {
        let txtView = UITextView()
        txtView.layer.borderWidth = 1
        txtView.layer.borderWidth = 1
        txtView.layer.borderColor = UIColor.systemGray5.cgColor
        txtView.layer.cornerRadius = 8
        txtView.font = UIFont.systemFont(ofSize: 16)
        return txtView
    }()
    
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    
    // MARK: OBJECT
    private let disposeBag = DisposeBag()
    private let addThoughtsViewModel: AddThoughtListViewModel
    
    // MARK: INITIALIZATION
    init(viewModel: AddThoughtListViewModel = AddThoughtListViewModel()) {
        self.addThoughtsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupView()
        rxDoneAction()
        rxCancelAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - HELPERS
    
    private func setupView() {
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10,
                          bottom: nil, paddingBottom: 0,
                          left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 20,
                          right: nil, paddingRight: 0,
                          width: 0, height: 0,
                          centerX: nil, centerY: nil,
                          enableInsets: false)
        
        view.addSubview(titleTextField)
        titleTextField.anchor(top: titleLabel.bottomAnchor, paddingTop: 5,
                              bottom: nil, paddingBottom: 0,
                              left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 20,
                              right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 20,
                              width: 0, height: 0,
                              centerX: nil, centerY: nil,
                              enableInsets: false)
        
        view.addSubview(thoughtsLabel)
        thoughtsLabel.anchor(top: titleTextField.bottomAnchor, paddingTop: 20,
                             bottom: nil, paddingBottom: 0,
                             left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 20,
                             right: nil, paddingRight: 0,
                             width: 0, height: 0,
                             centerX: nil, centerY: nil,
                             enableInsets: false)
        
        view.addSubview(thoughtsTextView)
        thoughtsTextView.anchor(top: thoughtsLabel.bottomAnchor, paddingTop: 5,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20,
                                left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 20,
                                right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 20,
                                width: 0, height: 0,
                                centerX: nil, centerY: nil,
                                enableInsets: false)
    }
}

// MARK: - RxExtension
extension AddThoughtsViewController {
    
    private func rxDoneAction() {
        doneButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let titleText = self.titleTextField.text ?? ""
                let descritptionText = self.thoughtsTextView.text ?? ""
                if !self.addThoughtsViewModel.checkIsTextValid(titleText, descritptionText) {
                    self.presentEmptyAlert()
                } else {
                    self.backToMain()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func rxCancelAction() {
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                print("cancel pressed")
                guard let self = self else { return }
                self.backToMain()
            })
            .disposed(by: disposeBag)
    }
    
    private func backToMain() {
        dismiss(animated: true)
        let vc = ThoughtListViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
    
    private func presentEmptyAlert() {
        let alertController = UIAlertController(title: "Empty Thoughts",
                                                message: "Please add your title or thoughts texts",
                                                preferredStyle: .alert)
        alertController.view.tintColor = .orange
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - SwiftUI Preview
import SwiftUI
#if DEBUG
struct AddThoughtsControllerContainerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = AddThoughtsViewController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return AddThoughtsViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct AddThoughtsViewController_Previews: PreviewProvider {
    static var previews: some View {
        AddThoughtsControllerContainerView().colorScheme(.light) // or .dark
    }
}
#endif
