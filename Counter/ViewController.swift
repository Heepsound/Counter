//
//  ViewController.swift
//  Counter
//
//  Created by Владимир Горбачев on 13.10.2023.
//

import UIKit

class ViewController: UIViewController {

    private var isReset: Bool = false

    private var counter: Int = 0 {
        willSet(newValue) {
            if isReset {
                addHistory("значение сброшено")
            } else {
                if newValue < 0 {
                    addHistory("попытка уменьшить значение счётчика ниже 0")
                } else if newValue > counter {
                    addHistory("значение изменено на +\(newValue - counter)")
                } else {
                    addHistory("значение изменено на -\(counter - newValue)")
                }
            }
        }
        didSet {
            if counter < 0 {
                counter = 0
            }
            counterLabel.text = "Значение счётчика: \(counter)"
        }
    }
    
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var historyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 0;
        historyTextView.text = "История изменений:"
    }
    
    @IBAction func plusButtonTouchUpInside(_ sender: Any) {
        isReset = false
        counter += 1
    }
    
    @IBAction func minusButtonTouchUpInside(_ sender: Any) {
        isReset = false
        counter -= 1
    }
    
    @IBAction func clearButtonTouchUpInside(_ sender: Any) {
        isReset = true
        counter = 0
    }
    
    func addHistory(_ description: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
        
        historyTextView.text.append("\n[\(dateFormatter.string(from: Date.now))]: \(description)")
    }
    
}

