//
//  CountdownPicker.swift
//  Countdown
//
//  Created by Jordan Spell on 6/12/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

protocol CountdownPickerDelegate: AnyObject {
    func countdownPickerDidSelect(duration: TimeInterval)
}

class CountdownPicker: UIPickerView {
    
    var duration: TimeInterval {
        let minuteString = selectedRow(inComponent: 0)
        let secondString = selectedRow(inComponent: 2)
        
        let minutes = Int(minuteString)
        let seconds = Int(secondString)
        
        let totalSeconds = TimeInterval(minutes*60 + seconds)
        return totalSeconds
    }
    
    lazy var countdownPickerData: [[String]] = {
        let minutes: [String] = Array(0...60).map { String($0) }
        let seconds: [String] = Array(0...60).map { String($0) }
        
        let data: [[String]] = [minutes, ["min"], seconds, ["sec"]]
        return data
    }()
    
    weak var countdownPickerDelegate: CountdownPickerDelegate? 

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
        
        selectRow(1, inComponent: 0, animated: false)
        selectRow(30, inComponent: 2, animated: false)
        countdownPickerDelegate?.countdownPickerDidSelect(duration: duration)
    }
}

extension CountdownPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return countdownPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countdownPickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let timeValue = countdownPickerData[component][row]
        return timeValue
    }
}

extension CountdownPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countdownPickerDelegate?.countdownPickerDidSelect(duration: duration)
    }
}
