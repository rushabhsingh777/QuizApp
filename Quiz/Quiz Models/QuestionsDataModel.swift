//
//  QuestionsDataModel.swift
//  Quiz
//
//  Created by Rushabh Singh on 30/05/21.
//

import Foundation

enum QuestionType : Int {
    case TextType = 1
    case ImageType = 2
    case AudioType = 3
    case VideoType = 4
}

struct QuestionsDataModel{
    let questionType : QuestionType
    let questionId: Int
    let questionText: String
    let questionImageUrl: String
    let correctAnswerIds : [Int]
    let options: [Option]
    var userAnswers : [Int] = []
    
    init(question : QuestionModel) {
        self.questionId = question.questionId
        self.questionType = QuestionType(rawValue: question.questionType) ?? QuestionType.TextType
        self.questionText = question.questionText
        self.questionImageUrl = question.questionImageUrl
        self.correctAnswerIds = question.correctAnswerIds
        self.options = question.options
    }
}
