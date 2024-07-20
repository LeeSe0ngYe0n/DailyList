import UIKit

final class CategoryViewController: UIViewController {
  var categories: [CategoryData] = []
  private let categoryView: CategoryView = CategoryView()
  
  override func loadView() {
    self.view = categoryView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    categoryView.collectionView.delegate = self
    categoryView.collectionView.dataSource = self
    loadCategories()
    setNavigationBar()
  }
}

// MARK: - CollectionView 데이터소스 및 델리게이트
extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
    let category = categories[indexPath.item]
    cell.setCellData(with: category)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedCategory = categories[indexPath.item]
    tappedCategoryCell(with: selectedCategory)
  }
  
}

// MARK: - CollectionView FlowLayout 설정
extension CategoryViewController: UICollectionViewDelegateFlowLayout {
  // cell size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 30 - 10) / 2
    return CGSize(width: width, height: width)
  }
  // cell 간격
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 5, left: 15, bottom: 15, right: 15)
  }
}

// MARK: - Private Function
extension CategoryViewController {
  private func loadCategories() {
    guard let userId = UserDefaults.standard.value(forKey: "user_id") as? Int else {
      print("User ID not found")
      return
    }
    Task {
      do {
        let endpoint = SelectCategoryEndpoint(userId: userId)
        let responseData = try await NetworkService.shared.makeURLRequest(endpoint: endpoint)
        let categories = try JSONDecoder().decode([CategoryData].self, from: responseData)
        self.categories = categories
        categoryView.collectionView.reloadData()
      } catch {
        print("Failed to load categories: \(error)")
      }
    }
  }
  private func setNavigationBar() {
    self.navigationItem.setHidesBackButton(true, animated: true)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"),
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(tappedRightBarButton))
    self.navigationItem.rightBarButtonItem?.tintColor = .black
  }
  
  @objc private func tappedRightBarButton() {
    let addCategoryViewController = AddCategoryViewController()
    addCategoryViewController.delegate = self
    self.present(addCategoryViewController, animated: true)
  }
  
  private func tappedCategoryCell(with category: CategoryData) {
    let nextDetailCategoryViewController = DetailCategoryViewController()
    nextDetailCategoryViewController.category = category
    self.present(nextDetailCategoryViewController, animated: true)
  }
}

// MARK: - AddCategoryDelegate
extension CategoryViewController: AddCategoryDelegate {
  func didAddCategory(category: CategoryData) {
    self.categories.append(category)
    categoryView.collectionView.reloadData()
  }
}
