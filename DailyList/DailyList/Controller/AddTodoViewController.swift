import UIKit

final class AddTodoViewController: UIViewController {
  private let addTodoView = AddTodoView()
  private var userId: Int = 0
  var categoryId: Int?
  weak var delegate: AddTodoViewControllerDelegate?
  
  override func loadView() {
    self.view = addTodoView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let categoryId = categoryId {
      print("Received category ID: \(categoryId)")
    }
    loadUserId()
    setButtonAddTarget()
  }
}

// MARK: - Private Function
private extension AddTodoViewController {
  func setButtonAddTarget() {
    addTodoView.setCancelButtonTarget(target: self, action: #selector(tappedCancelButton), for: .touchUpInside)
    addTodoView.setAddTodoButtonTarget(target: self, action: #selector(tappedAddTodoButton), for: .touchUpInside)
    addTodoView.setSelectDateButtonTarget(target: self, action: #selector(tappedSelectDateButton), for: .touchUpInside)
  }
  
  @objc private func tappedSelectDateButton() {
    let calendarViewController: CalendarViewController = CalendarViewController()
    if let sheet = calendarViewController.sheetPresentationController {
      sheet.detents = [.medium(), .large()]
      sheet.largestUndimmedDetentIdentifier = .medium
      sheet.prefersScrollingExpandsWhenScrolledToEdge = false
      sheet.prefersEdgeAttachedInCompactHeight = true
      sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
    }
    present(calendarViewController, animated: true, completion: nil)
  }
  
  @objc private func tappedCancelButton() {
    self.dismiss(animated: true)
  }
  
  @objc func tappedAddTodoButton() {
    guard let categoryId = categoryId else { return }
    let addTodoData = AddTodoData(title: addTodoView.todoTextView.text!, isCompleted: false, date: Date.now)
    
    Task {
      do {
        let endpoint = AddTodoEndpoint(userId: self.userId, categoryId: categoryId, addTodoData: addTodoData)
        _ = try await NetworkService.shared.makeURLRequest(endpoint: endpoint)
        delegate?.updateDetailCategoryView()
        self.dismiss(animated: true)
      } catch {
        print("할 일 생성 실패 - \(error)")
      }
    }
  }
  
  func loadUserId() {
    guard let userId = UserDefaults.standard.value(forKey: "user_id") as? Int else {
      print("유저 아이디 없음")
      return
    }
    self.userId = userId
  }
}
