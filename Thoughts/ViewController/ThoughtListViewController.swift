////
////  ViewController.swift
////  Thoughts
////
////  Created by Hilmy Veradin on 25/04/22.
////
//
//import UIKit
//import CoreData
//
//class ThoughtListViewController: UIViewController, ProgrammaticView {
//  
//  //MARK: - Properties
//  
//  private lazy var addButton: UIButton = {
//    let btn = UIButton()
//    btn.backgroundColor = .darkGray
//    btn.tintColor = .white
//    return btn
//  }()
//  
//  private lazy var tableView: UITableView = {
//    let tbl = UITableView()
//    tbl.delegate = self
//    tbl.dataSource = self
//    return tbl
//  }()
//  
//  var fetchedResultsController: NSFetchedResultsController<Texts>!
//  
//  //MARK: - Life Cycles
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = .systemGray5
//    self.title = "Thoughts"
//    setupView()
//  }
//  
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//    presentingViewController?.viewWillDisappear(true)
//    self.navigationItem.hidesBackButton = true
//    fetchWhenLoaded()
//    if fetchedResultsController != nil {
//      fetchedResultsController.delegate = self
//    }
//  }
//  
//  override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//    
//  }
//  //MARK: - Helpers
//  func setupView() {
//    
//    view.addSubview(tableView)
//    tableView.translatesAutoresizingMaskIntoConstraints = false
//    tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0,
//                     bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0,
//                     left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 0,
//                     right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 0,
//                     width: 0, height: 0,
//                     centerX: nil, centerY: nil,
//                     enableInsets: false)
//    
//    let buttonSize = view.frame.width * 0.18
//    view.addSubview(addButton)
//    view.bringSubviewToFront(addButton)
//    addButton.anchor(top: nil, paddingTop: 0,
//                     bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20,
//                     left: nil, paddingLeft: 0,
//                     right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 20,
//                     width: buttonSize, height: buttonSize,
//                     centerX: nil, centerY: nil,
//                     enableInsets: false)
//    
//    addButton.layer.cornerRadius = buttonSize/2
//    addButton.clipsToBounds = true
//    
//    let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: buttonSize/2, weight: .medium))
//    addButton.setImage(image, for: .normal)
//    
//    addButton.addTarget(self, action: #selector(addNewNavigation), for: .touchUpInside)
//  }
//  
//  @objc func addNewNavigation() {
//    let vc = AddThoughtsViewController()
//    let navigationController = UINavigationController(rootViewController: vc)
//    navigationController.modalPresentationStyle = .fullScreen
//    present(navigationController, animated: true)
//  }
//  
//  
//}
//
////MARK: - Table View Config
//
//extension ThoughtListViewController: UITableViewDelegate, UITableViewDataSource {
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = ThoughtsCell()
//    let texts = fetchedResultsController.object(at: indexPath)
//    let viewModel = ThoughtViewViewModel(texts: texts)
//    cell.configure(viewModel: viewModel)
//    return cell
//  }
//  
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    guard let sectionInfo = fetchedResultsController.sections?[section] else {
//      return 0
//    }
//    return sectionInfo.numberOfObjects
//  }
//  
//  
//  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//    return true
//  }
//  
//  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//      let commit = fetchedResultsController.object(at: indexPath)
//      // Delete Record
//      ThoughtsDataManager.shared.managedContext.delete(commit)
//      ThoughtsDataManager.shared.saveContext()
//    }
//  }
//
//  
//  
//}
//
////MARK: - FetchResults Controller Delegate
//
//extension ThoughtListViewController: NSFetchedResultsControllerDelegate {
//  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    tableView.beginUpdates()
//  }
//  
//  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    tableView.endUpdates()
//  }
//  
//  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//    switch type {
//      
//    case .update:
//      if let indexPath = indexPath {
//        tableView.reloadRows(at: [indexPath], with: .none)
//      }
//      
//    case .move:
//      if let indexPath = indexPath {
//        tableView.moveRow(at: indexPath, to: newIndexPath!)
//      }
//      
//    case .delete:
//      if let indexPath = indexPath {
//        tableView.deleteRows(at: [indexPath], with: .none)
//      }
//      
//    case .insert:
//      if let newIndexPath = newIndexPath {
//        tableView.insertRows(at: [newIndexPath], with: .none)
//      }
//      
//    default:
//      tableView.reloadData()
//    }
//  }
//}
//
////MARK: - Core Data Helpers
//extension ThoughtListViewController: FetchData {
//  
//  func fetchWhenLoaded() {
//    fetchedResultsController = ThoughtsDataManager.shared.fetchThoughsController()
//    
//    do {
//      try fetchedResultsController.performFetch()
//    } catch let error as NSError {
//      print("Fetching error: \(error), \(error.userInfo)")
//    }
//  }
//  
//}
//
//// MARK: - SwiftUI Preview
//import SwiftUI
//#if DEBUG
//struct ListViewControllerContainerView: UIViewControllerRepresentable {
//  typealias UIViewControllerType = ThoughtListViewController
//  
//  func makeUIViewController(context: Context) -> UIViewControllerType {
//    return ThoughtListViewController()
//  }
//  
//  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
//}
//
//struct ListViewController_Previews: PreviewProvider {
//  static var previews: some View {
//    ListViewControllerContainerView().colorScheme(.light) // or .dark
//  }
//}
//#endif
//
