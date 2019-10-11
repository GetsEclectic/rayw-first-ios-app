//
//  ViewController.swift
//  BullsEye
//
//  Created by Ben Solwitz on 9/27/19.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var round = 0
    var score = 0
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var randomValueLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
    }

    @IBAction func showAlert() {
        let newPoints = 100 - abs(targetValue - currentValue)
        score += newPoints
        scoreLabel.text = String(score)
        
        let title: String

        if(newPoints == 100) {
            title = "Perfect!"
        } else if(newPoints > 95) {
            title = "Pretty good!"
        } else if(newPoints > 90) {
            title = "Not too bad..."
        } else {
            title = "Not even close!"
        }
        
        let message = "You scored: \(newPoints)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
        action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = Int(slider.value.rounded())
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        randomValueLabel.text = String(targetValue)
        
        currentValue = 50
        slider.value = Float(currentValue)
        
        round += 1
        roundLabel.text = String(round)
    }
    
    @IBAction func startOver() {
        round = 0
        score = 0
        scoreLabel.text = String(score)
        
        startNewRound()
    }
}

