import Foundation

protocol CalendarViewControllerDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}
