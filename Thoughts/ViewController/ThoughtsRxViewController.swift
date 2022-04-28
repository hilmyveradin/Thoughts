//
//  ThoughtsRxViewController.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 28/04/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ThoughtsRxViewController: UIViewController, ProgrammaticView {
  //MARK: - Properties
  private lazy var tableView: UITableView = {
    let tbl = UITableView()
//    tbl.delegate = self
//    tbl.dataSource = self
    tbl.register(ThoughtsCell.self, forCellReuseIdentifier: "DefaultCell")
    return tbl
  }()
  
  private lazy var addButton: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = .darkGray
    btn.tintColor = .white
    return btn
  }()
  
//  let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: ThoughtsRxViewController.self, action: #selector(addThougts))
  
  var thoughtListViewModel = ThoughtListViewModel()
  var disposeBag = DisposeBag()
  
  //MARK: - Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupView()
    observableTextsTableView()
  }
  
//  override func viewWillLayoutSubviews() {
//    super.viewWillLayoutSubviews()
//    navigationItem.rightBarButtonItem = addButton
//  }
  
  //MARK: - Helpers
  
  func setupView() {
    view.addSubview(tableView)
    tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0,
                     left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 0,
                     right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 0,
                     width: 0, height: 0,
                     centerX: nil, centerY: nil,
                     enableInsets: false)
    
    let buttonSize = view.frame.width * 0.18
    view.addSubview(addButton)
    view.bringSubviewToFront(addButton)
    addButton.anchor(top: nil, paddingTop: 0,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20,
                     left: nil, paddingLeft: 0,
                     right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 20,
                     width: buttonSize, height: buttonSize,
                     centerX: nil, centerY: nil,
                     enableInsets: false)
    
    addButton.layer.cornerRadius = buttonSize/2
    addButton.clipsToBounds = true
    
    let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: buttonSize/2, weight: .medium))
    addButton.setImage(image, for: .normal)
    
    addButton.addTarget(self, action: #selector(addThougts), for: .touchUpInside)
  }
  
  
}

extension ThoughtsRxViewController {
  private func observableTextsTableView() {
    let observableTexts = thoughtListViewModel.getTexts().asObservable()
    observableTexts.bind(to: tableView.rx.items(cellIdentifier: "DefaultCell", cellType: ThoughtsCell.self)) { (row, element, cell) in
      
      cell.thoughtsTitle.text = element.textTitle
      cell.thoughtsDesc.text = element.textDescription
      
    }.disposed(by: disposeBag)
    
  }
  
  @objc private func addThougts() {
    addButton.rx.tap
      .subscribe(onNext: {
        let addTodoAlert = UIAlertController(title: "Add Todo", message: "Enter your string", preferredStyle: .alert)

        addTodoAlert.addTextField(configurationHandler: nil)
        addTodoAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { al in
            let todoString = addTodoAlert.textFields![0].text
            if !(todoString!.isEmpty) {
              self.thoughtListViewModel.saveThought(titleText: todoString!, descText: "", date: Date())
//              ThoughtsDataManager.shared.saveThought(titleText: todoString!, descText: "", date: Date())
            }
        }))

        addTodoAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

        self.present(addTodoAlert, animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
  }
}

//extension ThoughtsRxViewController: UITableViewDataSource, UITableViewDelegate {
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    return UITableViewCell()
//  }
//
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 100
//  }
//
//}
