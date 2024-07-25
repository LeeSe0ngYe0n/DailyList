import UIKit

final class AddTodoView: UIView {
  var selectedDate: Date? {
    didSet {
      updateSelectedDateLabel()
    }
  }
  
  private lazy var cancelButton: UIButton = {
    let bt: UIButton = UIButton()
    bt.setTitle("Cancel", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    return bt
  }()
  
  lazy var selectDateButton: UIButton = {
    let bt: UIButton = UIButton()
    bt.setImage(UIImage(systemName: "calendar.badge.plus"), for: .normal)
    bt.tintColor = .black
    return bt
  }()
  
  private lazy var selectedDateLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .body)
    label.textColor = .black
    label.text = Date.todayAsString()
    return label
  }()
  
  private lazy var topStackView: UIStackView = {
    let st: UIStackView = UIStackView(arrangedSubviews: [selectDateButton, selectedDateLabel, cancelButton])
    st.axis = .horizontal
    st.distribution = .equalSpacing
    self.addSubview(st)
    return st
  }()
  
  private lazy var todoTextView: UITextView = {
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
    updateSelectedDateLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setBottomButtonConstraint(_ constraint: inout NSLayoutConstraint?) {
    constraint = addTodoButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
  }
  
  private func setAutolayout() {
    topStackView.translatesAutoresizingMaskIntoConstraints = false
    todoTextView.translatesAutoresizingMaskIntoConstraints = false
    addTodoButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      topStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
      topStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
      topStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
      
      todoTextView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 16),
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

// MARK: - Function
extension AddTodoView {
  private func updateSelectedDateLabel() {
    guard let date = selectedDate else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    selectedDateLabel.text = dateFormatter.string(from: date)
  }
  func getTodoText() -> String {
    return todoTextView.text
  }
}
