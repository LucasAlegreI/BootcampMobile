import UIKit

class TimerControler{
    var timer: Timer?
    var secondsRemaining = 30
    func startTimer(temporizadorLabel:UILabel, onFinish: @escaping () -> Void) {
        secondsRemaining=30
        temporizadorLabel.text = "\(secondsRemaining)"
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
                temporizadorLabel.text = "\(self.secondsRemaining)"
            } else {
                self.timer?.invalidate()
                self.timer = nil
                temporizadorLabel.text = "¡Tiempo!"
                onFinish()
            }
        }
    }
}
