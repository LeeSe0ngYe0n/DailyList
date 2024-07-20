import UIKit

final class AddCategoryViewController: UIViewController {
  weak var delegate: AddCategoryDelegate?
  private let addCategoryView = AddCategoryView()
  private var userId: Int = 0
  
  override func loadView() {
    self.view = addCategoryView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtonAddTarget()
    loadUserId()
  }
  
  private func setButtonAddTarget() {
    addCategoryView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    addCategoryView.addCategoryButton.addTarget(self, action: #selector(tappedAddCategoryButton), for: .touchUpInside)
  }
  
  @objc private func tappedCancelButton() {
    self.dismiss(animated: true)
  }
  
  @objc private func tappedAddCategoryButton() {
    guard let categoryName = addCategoryView.categoryTextField.text, !categoryName.isEmpty else { return }
    let categoryData = AddCategoryData(userId: userId, categoryName: categoryName, icon: addCategoryView.selectedIcon, color: addCategoryView.selectedColor)
    
    Task {
      do {
        let endpoint = AddCategoryEndpoint(userId: categoryData.userId, categoryName: categoryData.categoryName, icon: categoryData.icon, color: categoryData.color)
        let responseData = try await NetworkService.shared.makeURLRequest(endpoint: endpoint)
        let insertedCategory = try JSONDecoder().decode(CategoryData.self, from: responseData)
        delegate?.didAddCategory(category: insertedCategory)
      } catch {
        print("카테고리 생성 실패 - \(error)")
      }
    }
    
    self.dismiss(animated: true)
  }
  
  private func loadUserId() {
    guard let userId = UserDefaults.standard.value(forKey: "user_id") as? Int else {
      print("유저 아이디 없음")
      return
    }
    self.userId = userId
  }
}


