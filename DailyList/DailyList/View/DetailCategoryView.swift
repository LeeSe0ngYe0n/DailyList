import UIKit

final class DetailCategoryView: UIView {
  lazy var categoryIcon: UIImageView = {
    let iv: UIImageView = UIImageView()
    return iv
  }()
  
  private lazy var  categoryLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.font = .systemFont(ofSize: 25)
    return lb
  }()
  
  private lazy var titleStackView: UIStackView = {
    let st: UIStackView = UIStackView(arrangedSubviews: [categoryIcon, categoryLabel])
    st.distribution = .equalSpacing
    st.axis = .horizontal
    st.spacing = 10
    self.addSubview(st)
    return st
  }()
  
  private lazy var cancelButton: UIButton = {
    let bt: UIButton = UIButton()
    bt.setTitle("Cancel", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    self.addSubview(bt)
    return bt
  }()
  
  private lazy var todoCountLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.textColor = .systemGray4
    self.addSubview(lb)
    return lb
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(DetailCategoryCell.self, forCellReuseIdentifier: DetailCategoryCell.identifier)
    self.addSubview(tableView)
    return tableView
  }()
  
  private lazy var addTodoButton: CustomButton = {
    let bt: CustomButton = CustomButton(title: "Add Todo")
    bt.isEnabled = true
    bt.layer.opacity = 1
    bt.layer.masksToBounds = true
    self.addSubview(bt)
    return bt
  }()
  
  private lazy var emptyLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.text = "Empty..."
    lb.font = .systemFont(ofSize: 50)
    lb.textColor = .systemGray3
    self.addSubview(lb)
    return lb
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    hasTodoSetAutoLayout()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - AutoLayout
extension DetailCategoryView {
  func setAutoLayout(todoCount: Int) {
    if todoCount == 0 {
      emptyTodoSetAutoLayout()
    } else {
      hasTodoSetAutoLayout()
    }
  }
  
  private func hasTodoSetAutoLayout() {
    titleStackView.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    todoCountLabel.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    addTodoButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
      titleStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      
      cancelButton.topAnchor.constraint(equalTo: titleStackView.topAnchor, constant: -10),
      cancelButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      
      titleStackView.trailingAnchor.constraint(lessThanOrEqualTo: cancelButton.leadingAnchor, constant: -10),
      
      categoryIcon.widthAnchor.constraint(equalToConstant: 30),
      
      todoCountLabel.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 5),
      todoCountLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
      
      tableView.topAnchor.constraint(equalTo: todoCountLabel.bottomAnchor, constant: 5),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: addTodoButton.topAnchor),
      
      addTodoButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
      addTodoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      addTodoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      addTodoButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      addTodoButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  private func emptyTodoSetAutoLayout() {
    titleStackView.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    emptyLabel.translatesAutoresizingMaskIntoConstraints = false
    addTodoButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
      titleStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      
      cancelButton.topAnchor.constraint(equalTo: titleStackView.topAnchor, constant: -10),
      cancelButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      
      titleStackView.trailingAnchor.constraint(lessThanOrEqualTo: cancelButton.leadingAnchor, constant: -10),
      
      categoryIcon.widthAnchor.constraint(equalToConstant: 30),
      
      emptyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      emptyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      
      addTodoButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
      addTodoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      addTodoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      addTodoButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      addTodoButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}

// MARK: - Function
extension DetailCategoryView {
  func setData(with category: CategoryData, todoCount: [TodoData]) {
    categoryIcon.image = UIImage(systemName: category.icon)
    categoryIcon.tintColor = UIColor(hex: category.color)
    categoryLabel.text = category.name
    let todoCount = todoCount.filter { !$0.isCompleted }.count
    if todoCount == 0 {
      todoCountLabel.text = ""
    } else {
      todoCountLabel.text = "\(todoCount) 작업"
    }
  }
  
  // 이 방법이 맞는지 궁금하다
  func setTableViewDataSourceDelegate(dataSourceDelegate: UITableViewDataSource & UITableViewDelegate) {
    tableView.dataSource = dataSourceDelegate
    tableView.delegate = dataSourceDelegate
  }
  
  func tableViewReloadData(){
    tableView.reloadData()
  }
  
  func tableViewReloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
    tableView.reloadRows(at: indexPaths, with: animation)
  }
}

// MARK: - Add Target
extension DetailCategoryView {
  func setCancelButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    cancelButton.addTarget(target, action: action, for: event)
  }
  
  func setAddTodoButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    addTodoButton.addTarget(target, action: action, for: event)
  }
}
