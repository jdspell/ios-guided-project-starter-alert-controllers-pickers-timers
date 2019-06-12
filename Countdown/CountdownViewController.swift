//
//  CountdownViewController.swift
//  Countdown
//
//  Created by Paul Solt on 5/8/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var countdownPicker: CountdownPicker!
    
    private let countdown = Countdown()
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SS"
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        countdown.duration = 5
        countdown.duration = countdownPicker.duration
        countdown.delegate = self
        
        countdownPicker.countdownPickerDelegate = self
        
        timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeLabel.font.pointSize, weight: .medium)
        updateViews()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
//        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: timerFinished(timer:))
        countdown.start()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        countdown.reset()
        updateViews()
    }
    
    private func timerFinished(timer: Timer) {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Timer Finished!", message: "Your countdowm is over.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func updateViews() {
        switch countdown.state {
        case .started:
            timeLabel.text = string(from: countdown.timeRemaining)
            
        case .finished:
            timeLabel.text = string(from: 0)
            
        case .reset:
            timeLabel.text = string(from: countdown.duration)
        }
    }
    
    func string(from duration: TimeInterval) -> String {
        let date = Date(timeIntervalSinceReferenceDate: duration)
        return dateFormatter.string(from: date)
    }
}

extension CountdownViewController: CountdownDelegate {
    
    func countdownDidUpdate(timeRemaining: TimeInterval) {
        updateViews()
    }
    
    func countdownDidFinish() {
        updateViews()
        showAlert()
    }

}

extension CountdownViewController: CountdownPickerDelegate {
    func countdownPickerDidSelect(duration: TimeInterval) {
        countdown.duration = duration
        updateViews()
    }
}
