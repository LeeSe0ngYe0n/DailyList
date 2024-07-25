import UIKit

final class ForgotPasswordView: UIView {
  private lazy var cancelButton: UIButton = {
    let bt: UIButton = UIButton()
    bt.setTitle("Cancel", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    self.addSubview(bt)
    return bt
  }()
  
  private lazy var mainLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.text = "Reset your password"
    lb.font = .preferredFont(forTextStyle: .title1)
    lb.textAlignment = .center
    self.addSubview(lb)
    return lb
  }()
  
  private lazy var subLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.numberOfLines = 4
    lb.font = .preferredFont(forTextStyle: .footnote)
    lb.text = "Please enter your registered email address.\nWe will send you a new password in a few minutes."
    lb.textAlignment = .center
    self.addSubview(lb)
    return lb
  }()
  
  private lazy var emailTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Email"
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.addTarget(self, action: #selector(sendButtonEnabled), for: .editingChanged)
    self.addSubview(tf)
    return tf
  }()

  private lazy var sendButton: CustomButton = {
    let bt = CustomButton(title: "Send")
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
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.endEditing(true)
  }
  
  @objc private func sendButtonEnabled(_ textfield: UITextField) {
    guard
      let email = emailTextField.text
    else {
      return
    }
    
    if !email.isEmpty {
      sendButton.layer.opacity = 1
      sendButton.isEnabled = true
    } else {
      sendButton.layer.opacity = 0.2
      sendButton.isEnabled = false
    }
  }
  

}

// MARK: - Autolayout
extension ForgotPasswordView {
  func setAutolayout() {
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    mainLabel.translatesAutoresizingMaskIntoConstraints = false
    subLabel.translatesAutoresizingMaskIntoConstraints = false
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    sendButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
      cancelButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
      
      mainLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 230),
      mainLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
      mainLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
      
      subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
      subLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      subLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
      
      emailTextField.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 30),
      emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
      emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
      
      sendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
      sendButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
      sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      sendButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}

// MARK: - AddTarget
extension ForgotPasswordView {
  func setCancelButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    cancelButton.addTarget(target, action: action, for: event)
  }
  
  func setSendButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    sendButton.addTarget(target, action: action, for: event)
  }
}
