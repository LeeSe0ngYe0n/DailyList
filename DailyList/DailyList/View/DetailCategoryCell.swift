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
    lb.text = "임시값"
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
    todoLabel.text = nil
    todoLabel.attributedText = nil
    todoLabel.textColor = nil
    checkBox.tintColor = nil
    overdueLabel.text = nil
  }
  
  // title을 다 넣어주는게 맞나? -> 해결 완료 -> 여러번 누르면 다시 문제가 발생한다.
  func configure(with todo: TodoData, isChecked: Bool, indexPath: IndexPath, target: Any, action: Selector) {
    todoLabel.text = todo.title
    
    if todo.isCompleted {
//      todoLabel.attributedText = String().strikeThrough() // 바보같이 여기서 빈 문자열로 만들어 주고 있었음
      todoLabel.attributedText = todo.title.strikeThrough()
      todoLabel.textColor = .systemGray3
      checkBox.tintColor = .systemGray3
      checkBox.isSelected = true
    } else {
      todoLabel.textColor = .black
      checkBox.tintColor = .black
      checkBox.isSelected = false
    }
    
    checkBox.tag = indexPath.row
    checkBox.removeTarget(nil, action: nil, for: .allEvents)
    checkBox.addTarget(target, action: action, for: .touchUpInside)
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
