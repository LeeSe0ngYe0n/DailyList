import UIKit

final class CategoryView: UIView {
  lazy var searchBar: UISearchBar = {
    let sb: UISearchBar = UISearchBar()
    sb.placeholder = "Search"
    sb.searchBarStyle = .minimal // searchbar 테두리 지우기
    self.addSubview(sb)
    return sb
  }()
  
  lazy var  collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 1
    layout.minimumLineSpacing = 15
    let cv: UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
    cv.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    cv.layer.borderColor = .none
    cv.layer.borderWidth = 0
    cv.layer.masksToBounds = true
    self.addSubview(cv)
    return cv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    setAutolayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - AutoLayout
extension CategoryView {
  private func setAutolayout() {
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}

