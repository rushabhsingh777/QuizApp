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
        mediaView.isHidden = true
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
                checkMediaQuestions()
                optionsTableView.reloadData()
            }
        }
    }
    
    private func checkMediaQuestions(){
        if self.questions[currentIndex].questionType == QuestionType.TextType{
            mediaViewHeightConstraint.constant = 0
            mediaView.isHidden = true
        }else{
            configureMediaView()
        }
    }
    
    private func configureMediaView(){
        let questionType = self.questions[currentIndex].questionType
        switch questionType {
        case QuestionType.ImageType:
            addImageQuestion()
        case QuestionType.AudioType:
            addAudioQuestion()
        case QuestionType.VideoType:
            addVideoQuestion()
        default:
            mediaViewHeightConstraint.constant = 0
            mediaView.isHidden = true
        }
    }
    
    private func addImageQuestion(){
        if self.questions[currentIndex].questionImageUrl.isEmpty{
            mediaViewHeightConstraint.constant = 0
            mediaView.isHidden = true
        }else{
            mediaView.isHidden = false
            let imageUrl = URL(string: self.questions[currentIndex].questionImageUrl)
            let imageView = LazyImageView(frame:CGRect(x:0, y:0, width:300, height:200));
            imageView.loadImage(fromURL: imageUrl!, placeHolderImage: ImagesNameConstant.placeholder)
            imageView.contentMode = UIView.ContentMode.scaleToFill
            mediaView.addSubview(imageView)
            mediaViewHeightConstraint.constant = 200 //store in constant
        }
    }
    
    private func addVideoQuestion(){
        //Add video player in media view
    }
    
    private func addAudioQuestion(){
        
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

