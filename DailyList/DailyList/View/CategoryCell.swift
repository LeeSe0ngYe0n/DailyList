import UIKit

final class CategoryCell: UICollectionViewCell {
  static let identifier: String = String(describing: CategoryCell.self)
  
  lazy var iconImageView: UIImageView = {
    let iv = UIImageView()
    iv.tintColor = .black
    iv.contentMode = .scaleAspectFit
    self.addSubview(iv)
    return iv
  }()
  
  lazy var categoryNameLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.textColor = .black
    lb.textAlignment = .left
    lb.font = .preferredFont(forTextStyle: .subheadline)
    self.addSubview(lb)
    return lb
  }()
  
  lazy var todoCount: UILabel = {
    let lb: UILabel = UILabel()
    lb.textColor = .systemGray3
    lb.textAlignment = .left
    lb.font = .preferredFont(forTextStyle: .footnote)
    self.addSubview(lb)
    return lb
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setAutolayout()
    setCellBorder()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setAutolayout() {
    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
    todoCount.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
      iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      iconImageView.widthAnchor.constraint(equalToConstant: 24),
      iconImageView.heightAnchor.constraint(equalToConstant: 24),
      
      categoryNameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 70),
      categoryNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      categoryNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
      
      todoCount.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: 10),
      todoCount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
    ])
  }
  
  private func setCellBorder() {
    contentView.layer.borderWidth = 1.0
    contentView.layer.borderColor = UIColor.lightGray.cgColor
    contentView.layer.cornerRadius = 8.0
  }
  
  func setCellData(with category: CategoryData) {
    iconImageView.image = UIImage(systemName: category.icon)
    iconImageView.tintColor = UIColor(hex: category.color)
    categoryNameLabel.text = category.name
  }
}

