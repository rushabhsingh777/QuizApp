//
//  QuizDataModel.swift
//  Quiz
//
//  Created by Rushabh Singh on 29/05/21.
//

import Foundation
// MARK: - WelcomeElement

struct QuestionModel: Codable {
    let questionType, questionId: Int
    let questionText: String
    let correctAnswerIds : [Int]
    let options: [Option]
}

struct Option: Codable {
    let id: Int
    let text: String
}



