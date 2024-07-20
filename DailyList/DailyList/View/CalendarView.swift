import UIKit

final class CalendarView: UIView {
  private lazy var datePicker = {
    let dp: UIDatePicker = UIDatePicker()
    dp.datePickerMode = .date
    dp.preferredDatePickerStyle = .inline
    dp.date = .now
    dp.tintColor = .black
    dp.addTarget(self, action: #selector(tappedDate), for: .valueChanged)
    self.addSubview(dp)
    return dp
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setAutolayout()
    self.backgroundColor = .white
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Autolayout
extension CalendarView {
  private func setAutolayout() {
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      datePicker.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      datePicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      datePicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      datePicker.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
    ])
  }
}

// MARK: - AddTarget
extension CalendarView {
  @objc func tappedDate() {
    print(datePicker.date)
  }
}
