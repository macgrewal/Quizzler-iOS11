//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let questions = QuestionBank()
    var currentIndex = 0
    var currentQuestion = Question(text: "", correctAnswer: false)
    var answer = false
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        answer = sender.tag == 1
        
        checkAnswer()
    }
    
    func updateUI() {
        currentQuestion = questions.list[currentIndex]
        questionLabel.text = currentQuestion.questionText
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(currentIndex + 1)/13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(currentIndex + 1)
    }

    func nextQuestion() {
        if (currentIndex < questions.list.count - 1) {
            currentIndex += 1
            updateUI()
        } else {
            let alert = UIAlertController(title: "Restart", message: "You have completed the quiz and scored \(score)/\(questions.list.count).", preferredStyle: .alert)
            let action = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in self.startOver()})
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func checkAnswer() {
        if answer == currentQuestion.answer {
            score += 1
            ProgressHUD.showSuccess("Correct")
        }
        else {
            ProgressHUD.showError("Wrong")
        }
        
        nextQuestion()
    }
    
    func startOver() {
        currentIndex = 0
        score = 0
        updateUI()
    }
    
}
