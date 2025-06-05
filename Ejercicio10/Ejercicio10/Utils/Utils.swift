import UIKit
extension Date {
  func formatearFecha() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yyyy"
    return formatter.string(from: self)
  }
}
