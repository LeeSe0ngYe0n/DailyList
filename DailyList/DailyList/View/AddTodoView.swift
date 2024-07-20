import UIKit

final class AddTodoView: UIView {
  lazy var cancelButton: UIButton = {
    let bt: UIButton = UIButton()
    bt.setTitle("Cancel", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    self.addSubview(bt)
    return bt
  }()
  
  lazy var selectDateButton: UIButton = {
    let bt: UIButton = UIButton()
    bt.setImage(UIImage(systemName: "calendar.badge.plus"), for: .normal)
    bt.tintColor = .black
    self.addSubview(bt)
    return bt
  }()
  
  lazy var todoTextView: UITextView = {
    let tv = UITextView()
    tv.font = .preferredFont(forTextStyle: .body)
    tv.delegate = self
    self.addSubview(tv)
    return tv
  }()
  
  private lazy var addTodoButton: UIButton = {
    let bt = UIButton(type: .system)
    bt.setImage(UIImage(systemName: "plus.app"), for: .normal)
    bt.backgroundColor = .black
    bt.tintColor = .white
    bt.layer.opacity = 0.2
    bt.layer.masksToBounds = true
    bt.isEnabled = false
    self.addSubview(bt)
    return bt
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    setAutolayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setBottomButtonConstraint(_ constraint: inout NSLayoutConstraint?) {
    constraint = addTodoButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
  }
  
  private func setAutolayout() {
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    selectDateButton.translatesAutoresizingMaskIntoConstraints = false
    todoTextView.translatesAutoresizingMaskIntoConstraints = false
    addTodoButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      selectDateButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
      selectDateButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
      
      cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
      cancelButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
      
      todoTextView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 16),
      todoTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
      todoTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
      
      addTodoButton.topAnchor.constraint(equalTo: todoTextView.bottomAnchor, constant: 16),
      addTodoButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      addTodoButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      addTodoButton.heightAnchor.constraint(equalToConstant: 60),
      addTodoButton.bottomAnchor.constraint(equalTo:self.keyboardLayoutGuide.topAnchor),
    ])
  }
}

// MARK: - Add Target
extension AddTodoView {
  func setAddTodoButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    addTodoButton.addTarget(target, action: action, for: event)
  }
  
  func setCancelButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    cancelButton.addTarget(target, action: action, for: event)
  }
  
  func setSelectDateButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    selectDateButton.addTarget(target, action: action, for: event)
  }
}

// MARK: - UITextViewDelegate
extension AddTodoView: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    if !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      addTodoButton.layer.opacity = 1
      addTodoButton.isEnabled = true
    } else {
      addTodoButton.layer.opacity = 0.2
      addTodoButton.isEnabled = false
    }
  }
}
