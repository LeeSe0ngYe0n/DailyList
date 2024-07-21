import UIKit

final class DetailCategoryCell: UITableViewCell {
  static let identifier: String = String(describing: DetailCategoryCell.self)
  
  private lazy var checkBox: UIButton = {
    let bt: UIButton = UIButton()
    bt.tintColor = .black
    bt.setImage(UIImage(systemName: "square"), for: .normal)
    bt.setImage(UIImage(systemName: "checkmark"), for: .selected)
    contentView.addSubview(bt)
    return bt
  }()
  
  private lazy var todoLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.font = UIFont.systemFont(ofSize: 16)
    lb.numberOfLines = 0
    contentView.addSubview(lb)
    return lb
  }()
  
  private lazy var overdueLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.textColor = .black
    lb.font = .preferredFont(forTextStyle: .footnote)
    contentView.addSubview(lb)
    return lb
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    checkBox.isSelected = false
    // attributedText를 먼저 nil로 초기화 해주지 않으면 UI 적으로 문제가 생김 -> 기존에는 attributedText 보다 todoLabel.text를 먼저 nil 값으로 초기화 해줌.
    todoLabel.attributedText = nil
    todoLabel.text = nil
    todoLabel.textColor = nil
    checkBox.tintColor = nil
//    overdueLabel.text = nil
    
  }
  
  func configure(with todo: TodoData, isChecked: Bool, indexPath: IndexPath, target: Any, action: Selector) {
    todoLabel.attributedText = NSAttributedString(string: todo.title)
//    todoLabel.text = todo.title
    
    if todo.isCompleted {
      todoLabel.attributedText = todo.title.strikeThrough()
      todoLabel.textColor = .systemGray3
      checkBox.tintColor = .systemGray3
      overdueLabel.textColor = .systemGray3
      checkBox.isSelected = true
    } else {
      
      todoLabel.textColor = .black
      overdueLabel.textColor = .black
      checkBox.tintColor = .black
      checkBox.isSelected = false
    }
    
    checkBox.tag = indexPath.row
    checkBox.removeTarget(nil, action: nil, for: .allEvents)
    checkBox.addTarget(target, action: action, for: .touchUpInside)
    
//    let formatter = DateFormatter()
//    formatter.dateFormat = "MM월 dd일"
//    
//    let today = Date()
//    let calendar = Calendar.current
//    
//    let isOverdue = today > todo.dueDate
//    if isOverdue {
//      let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
//      if calendar.isDate(todo.dueDate, inSameDayAs: yesterday) {
//        overdueLabel.text = "어제"
//      } else {
//        overdueLabel.text = formatter.string(from: todo.dueDate)
//      }
//    } else {
//      overdueLabel.text = formatter.string(from: todo.dueDate)
//    }
  }
}

// MARK: - AutoLayout
extension DetailCategoryCell {
  private func setAutoLayout() {
    checkBox.translatesAutoresizingMaskIntoConstraints = false
    todoLabel.translatesAutoresizingMaskIntoConstraints = false
    overdueLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      checkBox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
      checkBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      checkBox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      todoLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 8),
      todoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      todoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      todoLabel.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor),
      
      overdueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
      overdueLabel.leadingAnchor.constraint(equalTo: todoLabel.leadingAnchor)
    ])
  }
}
