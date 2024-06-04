//
//  EggTimerViewController.swift
//  FITDIARY
//

import UIKit

class EggTimerViewController: UIViewController {
    
    let segmentedControl = UISegmentedControl(items: ["Soft Boiled", "Medium Boiled", "Hard Boiled"])
    let imageView = UIImageView()
    let timerLabel = UILabel()
    let startButton = UIButton(type: .system)
    let stopButton = UIButton(type: .system)
    let resetButton = UIButton(type: .system)
    var timer: Timer?
    var countdown: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        view.addSubview(segmentedControl)
        
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 32)
        view.addSubview(timerLabel)
        
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(startButton)
        
        stopButton.setTitle("Stop", for: .normal)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        view.addSubview(stopButton)
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        view.addSubview(resetButton)
        
        // Layout
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timerLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            stopButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            resetButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            imageView.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        segmentedControlChanged()
    }
    
    @objc func segmentedControlChanged() {
        timer?.invalidate()
        timer = nil
        countdown = 0
        updateTimerLabel()
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            countdown = 300 // Soft Boiled: 5 minutes
            imageView.image = UIImage(named: "soft_boiled")
        case 1:
            countdown = 420 // Medium Boiled: 7 minutes
            imageView.image = UIImage(named: "medium_boiled")
        case 2:
            countdown = 600 // Hard Boiled: 10 minutes
            imageView.image = UIImage(named: "hard_boiled")
        default:
            break
        }
        updateTimerLabel()
    }
    
    @objc func startButtonTapped() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func stopButtonTapped() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func resetButtonTapped() {
        timer?.invalidate()
        timer = nil
        segmentedControlChanged()
    }
    
    @objc func updateCountdown() {
        if countdown > 0 {
            countdown -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
            timer = nil
            let alert = UIAlertController(title: "Time's Up", message: "Your egg is ready!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func updateTimerLabel() {
        timerLabel.text = "\(countdown / 60):\(String(format: "%02d", countdown % 60))"
    }
}
