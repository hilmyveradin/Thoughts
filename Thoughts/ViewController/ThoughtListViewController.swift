//
//  ViewController.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 25/04/22.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class ThoughtListViewController: UIViewController, ProgrammaticView {
  
  //MARK: - Properties
  
  private lazy var addButton: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = .darkGray
    btn.tintColor = .white
    return btn
  }()
  
  private lazy var tableView: UITableView = {
    let tbl = UITableView()
    tbl.register(ThoughtsCell.self, forCellReuseIdentifier: "DefaultCell")
    return tbl
  }()
  
  
  var thoughtListViewModel = ThoughtListViewModel()
  var disposeBag = DisposeBag()
  
  //MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray5
    self.title = "Thoughts"
    self.navigationItem.hidesBackButton = true
    setupView()
    observableTextsTableView()
    setupTodoListTableViewCellWhenDeleted()
  }
  
  //MARK: - Helpers
  func setupView() {
    
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
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
    
    addButton.addTarget(self, action: #selector(addNewNavigation), for: .touchUpInside)
  }
  
  @objc func addNewNavigation() {
    let vc = AddThoughtsViewController()
    let navigationController = UINavigationController(rootViewController: vc)
    navigationController.modalPresentationStyle = .fullScreen
    present(navigationController, animated: true)
  }
  
  
}

//MARK: - RxActions
extension ThoughtListViewController {
  private func observableTextsTableView() {
    let observableTexts = ThoughtListViewModel.shared.getTexts().asObservable()
    observableTexts.bind(to: tableView.rx.items(cellIdentifier: "DefaultCell", cellType: ThoughtsCell.self)) { (row, element, cell) in
      print("called")
      cell.thoughtsTitle.text = element.textTitle
      cell.thoughtsDesc.text = element.textDescription
      
    }.disposed(by: disposeBag)
    
  }
  
  private func setupTodoListTableViewCellWhenDeleted() {
    tableView.rx.itemDeleted
      .subscribe(onNext : { indexPath in
        self.thoughtListViewModel.removeTodo(withIndex: indexPath.row)
      })
      .disposed(by: disposeBag)
  }
}


// MARK: - SwiftUI Preview
import SwiftUI
#if DEBUG
struct ListViewControllerContainerView: UIViewControllerRepresentable {
  typealias UIViewControllerType = ThoughtListViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    return ThoughtListViewController()
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ListViewController_Previews: PreviewProvider {
  static var previews: some View {
    ListViewControllerContainerView().colorScheme(.light) // or .dark
  }
}
#endif

