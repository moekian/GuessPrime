//
//  ViewController.swift
//  GuessPrime
//
//  Created by Mohammad Kiani on 2019-10-31.
//  Copyright © 2019 mohammadkiani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var prime: UILabel!
    @IBOutlet weak var nonPrime: UILabel!
    @IBOutlet weak var resImage: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: Timer?
    var seconds = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapPrime = UITapGestureRecognizer(target: self, action: #selector(checkPrime))
        let tapNonPrime = UITapGestureRecognizer(target: self, action: #selector(checkNonPrime))
        
        prime.addGestureRecognizer(tapPrime)
        nonPrime.addGestureRecognizer(tapNonPrime)
        
        loadRandomNumber()
        timerLabel.text = "5"
    }
    
    @objc func checkPrime() {
        let number = Int(self.number.text!) ?? 0
        if isPrime(number: number) {
            resImage.image = UIImage(named: "correct")
            print("Prime")
        }
        else {
            resImage.image = UIImage(named: "wrong")
            print("wrong answer")
        }
    }
    
    @objc func checkNonPrime() {
        let number = Int(self.number.text!) ?? 0
        if !isPrime(number: number) {
            print("Not Prime")
            resImage.image = UIImage(named: "correct")
        }
        else {
            print("wrong answer")
            resImage.image = UIImage(named: "wrong")
        }
    }
    
    func loadRandomNumber() {
        let number = Int(arc4random_uniform(100))
        self.number.text = "\(number)"
        resImage.image = UIImage(named: "")
        seconds = 6
        runTimer()
    }

    func isPrime(number: Int) -> Bool {
        if number <= 1 {return false}
        if number <= 3 {return true}
        var i = 2
        while i * i <= number {
            if number % i == 0 {return false}
            i += 1
        }
        return true
    }
    
    func runTimer() {
        guard timer == nil else {return}
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.updateTimer()
        })
    }
    
    func updateTimer() {
        if seconds == 0 {
            stopTimer()
            loadRandomNumber()
        }
        else {
            seconds -= 1
            timerLabel.text = "\(seconds)"
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

