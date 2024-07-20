import UIKit

final class AddCategoryView: UIView {
  let iconNames = IconName.allCases.map({"\($0.icon)"})
  let colorNames = ColorName.allCases.map({"\($0.color)"})
  
  var selectedIconIndex: Int = 0 {
    didSet {
      selectIcon(at: selectedIconIndex)
    }
  }
  
  var selectedColorIndex: Int = 0 {
    didSet {
      selectColor(at: selectedColorIndex)
    }
  }
  
  var selectedIcon: String {
    return iconNames[selectedIconIndex]
  }
  
  var selectedColor: String {
    return colorNames[selectedColorIndex]
  }
  
  lazy var cancelButton: UIButton = {
    let bt:UIButton = UIButton()
    bt.setTitle("Cancel", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    self.addSubview(bt)
    return bt
  }()
  
  lazy var categoryNameLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.text = "📁Category"
    lb.textColor = .black
    lb.font = UIFont.boldSystemFont(ofSize: 20)
    self.addSubview(lb)
    return lb
  }()
  
  lazy var categoryTextField: TextFieldUnderline = {
    let tf: TextFieldUnderline = TextFieldUnderline()
    tf.placeholder = "Enter a category name"
    tf.addTarget(self, action: #selector(addCategoryButtonEnabled), for: .editingChanged)
    self.addSubview(tf)
    return tf
  }()
  
  private lazy var iconLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.text = "📍Icon"
    lb.textColor = .black
    lb.font = UIFont.boldSystemFont(ofSize: 20)
    self.addSubview(lb)
    return lb
  }()
  
  private lazy var iconImageViews: [UIImageView] = {
    return iconNames.enumerated().map { index, iconName in
      let iv: UIImageView = createIconImageView(named: iconName)
      iv.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        iv.widthAnchor.constraint(equalToConstant: 36),
        iv.heightAnchor.constraint(equalToConstant: 36),
      ])
      if index == selectedIconIndex {
        enlargeIcon(iv)
      }
      return iv
    }
  }()
  
  private lazy var iconStackView: UIStackView = {
    let st: UIStackView = UIStackView(arrangedSubviews: iconImageViews)
    st.axis = .horizontal
    st.distribution = .equalSpacing
    st.spacing = 1
    self.addSubview(st)
    return st
  }()
  
  private lazy var colorLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.text = "🎨Color"
    lb.textColor = .black
    lb.font = UIFont.boldSystemFont(ofSize: 20)
    self.addSubview(lb)
    return lb
  }()
  
  private lazy var colorImageViews: [UIImageView] = {
    return colorNames.enumerated().map { index, hex in
      guard let color = UIColor(hex: hex) else { return UIImageView() }
      let iv: UIImageView = createColorImageView(color: color)
      iv.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        iv.widthAnchor.constraint(equalToConstant: 36),
        iv.heightAnchor.constraint(equalToConstant: 36)
      ])
      if index == selectedColorIndex {
        enlargeColor(iv)
      }
      return iv
    }
  }()
  
  lazy var colorStackView: UIStackView = {
    let st: UIStackView = UIStackView(arrangedSubviews: colorImageViews)
    st.axis = .horizontal
    st.distribution = .equalSpacing
    st.spacing = 1
    self.addSubview(st)
    return st
  }()
  
  lazy var addCategoryButton: CustomButton = {
    let bt: CustomButton = CustomButton(title: "Add Category")
    self.addSubview(bt)
    return bt
  }()
  
  // MARK: - View Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setAutolayout()
    backgroundColor = .white
    categoryTextField.becomeFirstResponder()
  }
  
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - AutoLayout
extension AddCategoryView {
  private func setAutolayout() {
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
    categoryTextField.translatesAutoresizingMaskIntoConstraints = false
    iconLabel.translatesAutoresizingMaskIntoConstraints = false
    iconStackView.translatesAutoresizingMaskIntoConstraints = false
    colorLabel.translatesAutoresizingMaskIntoConstraints = false
    colorStackView.translatesAutoresizingMaskIntoConstraints = false
    addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
      cancelButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
      
      categoryNameLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 30),
      categoryNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
      categoryNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
      
      categoryTextField.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: 10),
      categoryTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
      categoryTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
      
      iconLabel.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 30),
      iconLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
      
      iconStackView.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 20),
      iconStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      iconStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
      
      colorLabel.topAnchor.constraint(equalTo: iconStackView.bottomAnchor, constant: 30),
      colorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
      
      colorStackView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20),
      colorStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      colorStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
      
      addCategoryButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
      addCategoryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      addCategoryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
      addCategoryButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      addCategoryButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}

// MARK: - Private Function
extension AddCategoryView {
  private func setupViews() {
    selectIcon(at: selectedIconIndex)
    selectColor(at: selectedColorIndex)
  }
  
  private func createIconImageView(named iconName: String) -> UIImageView {
    let iv = UIImageView(image: UIImage(systemName: iconName))
    iv.tintColor = UIColor(hex: colorNames[selectedColorIndex])
    iv.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconTapped))
    iv.addGestureRecognizer(tapGesture)
    return iv
  }
  
  private func createColorImageView(color: UIColor) -> UIImageView {
    let iv: UIImageView = UIImageView()
    iv.backgroundColor = color
    iv.layer.masksToBounds = true
    iv.layer.cornerRadius = 18
    iv.layer.borderColor = UIColor.clear.cgColor
    iv.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(colorTapped))
    iv.addGestureRecognizer(tapGesture)
    return iv
  }
  
  @objc private func iconTapped(_ sender: UITapGestureRecognizer) {
    guard let selectedIcon = sender.view as? UIImageView,
          let index = iconImageViews.firstIndex(of: selectedIcon) else { return }
    selectedIconIndex = index
  }
  
  @objc private func colorTapped(_ sender: UITapGestureRecognizer) {
    guard let selectedColor = sender.view as? UIImageView,
          let index = colorImageViews.firstIndex(of: selectedColor) else { return }
    selectedColorIndex = index
    updateIconTintColor()
  }
  
  private func enlargeIcon(_ imageView: UIImageView) {
    imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
  }
  
  private func enlargeColor(_ imageView: UIImageView) {
    imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
  }
  
  private func selectIcon(at index: Int) {
    iconImageViews.forEach { $0.transform = .identity }
    enlargeIcon(iconImageViews[index])
  }
  
  private func selectColor(at index: Int) {
    colorImageViews.forEach { $0.transform = .identity }
    enlargeColor(colorImageViews[index])
    updateIconTintColor()
  }
  
  private func updateIconTintColor() {
    let selectedHexColor = colorNames[selectedColorIndex]
    guard let selectedColor = UIColor(hex: selectedHexColor) else { return }
    iconImageViews.forEach { $0.tintColor = selectedColor }
  }
  
  @objc private func addCategoryButtonEnabled(_ textfield: UITextField) {
    guard let category = categoryTextField.text else { return }
    addCategoryButton.isEnabled = !category.isEmpty
    addCategoryButton.layer.opacity = category.isEmpty ? 0.2 : 1
  }
}
