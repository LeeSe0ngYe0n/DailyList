import UIKit

final class CalendarViewController: UIViewController {
  private let calendarView: CalendarView = CalendarView()
  weak var delegate: CalendarViewControllerDelegate?
  
  override func loadView() {
    self.view = calendarView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    calendarView.delegate = self
  }
}

// MARK: - Function
extension CalendarViewController: CalendarViewDelegate {
    func didTapDate(_ date: Date) {
        delegate?.didSelectDate(date)
        dismiss(animated: true, completion: nil)
    }
}
