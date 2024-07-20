import UIKit

final class DetailCategoryViewController: UIViewController {
  var category: CategoryData?
  private var todo: AddTodoData?
  private var todos: [TodoData] = []
  private var overdueTodos: [TodoData] = []
  private var todayTodos: [TodoData] = []
  private let detailCategoryView: DetailCategoryView = DetailCategoryView()
  
  override func loadView() {
    self.view = detailCategoryView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadTodos()
    detailCategoryView.setTableViewDataSourceDelegate(dataSourceDelegate: self)
    setAddTarget()
  }
}

// MARK: - TableView
extension DetailCategoryViewController: UITableViewDataSource, UITableViewDelegate {
  //  func numberOfSections(in tableView: UITableView) -> Int {
  //    return 2 // 연체된 작업과 오늘의 작업
  //  }
  
  //  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
  //    switch section {
  //    case 0:
  //      return "Overdue"
  //    case 1:
  //      return "Today"
  //    default:
  //      return nil
  //    }
  //  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    switch section {
    //    case 0: // 연체된 작업
    //      return overdueTodos.count
    //    case 1: // 오늘의 작업
    //      return todayTodos.count
    //    default:
    //      return 0
    //    }
    todos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DetailCategoryCell.identifier, for: indexPath) as! DetailCategoryCell
    let todo = todos[indexPath.row]
    cell.configure(with: todo, isChecked: todo.isCompleted, indexPath: indexPath, target: self, action: #selector(tappedCheckbox))
    //    switch indexPath.section {
    //    case 0:
    //      let todo = overdueTodos[indexPath.row]
    //      cell.configure(with: todo, isChecked: todo.isCompleted, indexPath: indexPath, target: self, action: #selector(tappedCheckbox))
    //    case 1:
    //      let todo = todayTodos[indexPath.row]
    //      cell.configure(with: todo, isChecked: todo.isCompleted, indexPath: indexPath, target: self, action: #selector(tappedCheckbox))
    //    default:
    //      break
    //    }
    return cell
  }
}

// MARK: - Add Target
extension DetailCategoryViewController {
  private func setAddTarget() {
    detailCategoryView.setCancelButtonTarget(target: self, action: #selector(tappedCancelButton), for: .touchUpInside)
    detailCategoryView.setAddTodoButtonTarget(target: self, action: #selector(tappedAddTodoButton), for: .touchUpInside)
  }
  
  @objc private func tappedAddTodoButton() {
    print("tapped - tappedAddTodoButton")
    let addTodoViewController: AddTodoViewController = AddTodoViewController()
    addTodoViewController.categoryId = category?.categoryId
    addTodoViewController.delegate = self
    self.present(addTodoViewController, animated: true)
  }
  
  @objc private func tappedCancelButton() {
    self.dismiss(animated: true)
  }
  
  @objc private func tappedCheckbox(_ sender: UIButton) {
    let todo = todos[sender.tag]
    let newStatus = !todo.isCompleted
    
    // API 요청을 위한 준비
    guard let userId = UserDefaults.standard.value(forKey: "user_id") as? Int else {
      print("유저 아이디 없는디?")
      return
    }
    let endpoint = completeTodoEndpoint(userId: userId, todoId: todo.id)
    
    Task {
      do {
        // API 요청 전송 및 응답 처리
        _ = try await NetworkService.shared.makeURLRequest(endpoint: endpoint)
        
        // 데이터 모델 업데이트
        todos[sender.tag].isCompleted = newStatus
        
        // 특정 셀 재로드
        let indexPath = IndexPath(row: sender.tag, section: 0)
        detailCategoryView.tableViewReloadRows(at: [indexPath], with: .none)
        DispatchQueue.main.async {
          self.loadTodos()
        }
      } catch {
        print("Failed to update todo: \(error)")
      }
    }
  }
}

// MARK: - Function
extension DetailCategoryViewController: AddTodoViewControllerDelegate {
  func updateDetailCategoryView() {
    loadTodos()
  }
  
  private func loadTodos() {
    guard let categoryId = category?.categoryId else { return }
    guard let userId = UserDefaults.standard.value(forKey: "user_id") as? Int else {
      print("유저 아이디 없는디?")
      return
    }
    
    //    Task {
    //      do {
    //        let endpoint = DetailCategoryTodosEndpoint(categoryId: categoryId, userId: userId)
    //        let responseData = try await NetworkService.shared.makeURLRequest(endpoint: endpoint)
    //        self.todos = try JSONDecoder().decode([TodoData].self, from: responseData)
    //        detailCategoryView.setData(with: category!, todoCount: todos)
    //        detailCategoryView.setAutoLayout(todoCount: self.todos.count) // isEmpty 사용 -> cell 두개를 사용해서 상황에 맞게 껴넣는 방법도 있다!
    //        detailCategoryView.tableViewReloadData()
    //      } catch {
    //        print("Failed to load todos: \(error)")
    //      }
    //    }
    Task {
      do {
        let endpoint = DetailCategoryTodosEndpoint(categoryId: categoryId, userId: userId)
        let responseData = try await NetworkService.shared.makeURLRequest(endpoint: endpoint)
        
        // JSONDecoder 설정
        let decoder = JSONDecoder()
        // ISO 8601 형식의 날짜를 디코딩할 수 있도록 dateDecodingStrategy 설정
        decoder.dateDecodingStrategy = .iso8601
        
        // JSON 데이터를 TodoData 배열로 디코딩
        self.todos = try decoder.decode([TodoData].self, from: responseData)
        
        detailCategoryView.setData(with: category!, todoCount: todos)
        detailCategoryView.setAutoLayout(todoCount: self.todos.count)
        print(todos)
        detailCategoryView.tableViewReloadData()
      } catch {
        print("Failed to load todos: \(error)")
      }
    }
  }
}
