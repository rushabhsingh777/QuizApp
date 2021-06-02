//
//  ViewController.swift
//  Quiz
//
//  Created by Rushabh Singh on 29/05/21.
//

import UIKit

class QuestionViewController: UIViewController{
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mediaView: UIView!
    @IBOutlet weak var mediaViewHeightConstraint: NSLayoutConstraint!
    
    let QUESTIONS = "Questions"
    let QUESTION_TABLE_VIEW_CELL_IDENTIFIER = "QuestionTableViewCellIdentifier"
    var questions = [QuestionsDataModel]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = QUESTIONS
        self.navigationItem.setHidesBackButton(true, animated: true)
        setUpTableView()
        downloadQuestionsList()
        submitButton.isHidden = true
    }
    
    private func setUpTableView(){
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        self.optionsTableView.tableFooterView = UIView()
    }
    
    private func downloadQuestionsList(){
        QuizResource().getQuestions(){ (questions) in
            self.questions = questions
            self.updateQuestion()
        }
    }
    
    private func updateQuestion(){
        DispatchQueue.main.async { [self] in
            if currentIndex < self.questions.count {
                questionLabel.text = self.questions[currentIndex].questionText
                configureMediaView()
                optionsTableView.reloadData()
            }
        }
    }
    
    private func configureMediaView(){
        if self.questions[currentIndex].questionType == QuestionType.TextType{
            mediaViewHeightConstraint.constant = 0
        }else{
            //Handle all media types view
            //posterImage.loadImage(fromURL: , placeHolderImage: )
            mediaViewHeightConstraint.constant = 200
        }
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        DispatchQueue.main.async {
            let resultVC = ResultTableViewController()
            resultVC.questions = self.questions
            self.navigationController?.pushViewController(resultVC, animated: true)
            self.navigationController?.viewControllers.remove(at: 0)
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        //Getting next question and optons should be made in viewmodel just pass current index and get data 
        currentIndex += 1
        if currentIndex + 1 == self.questions.count{ //Last question
            submitButton.isHidden = false
            nextButton.isHidden = true
        }
        if currentIndex < self.questions.count{
            updateQuestion()
        }
    }
    
}

