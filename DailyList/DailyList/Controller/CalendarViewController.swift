import UIKit

final class CalendarViewController: UIViewController {
  private let calendarView: CalendarView = CalendarView()
  
  override func loadView() {
    self.view = calendarView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
