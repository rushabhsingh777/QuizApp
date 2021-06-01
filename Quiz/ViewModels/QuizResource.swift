//
//  QuizResource.swift
//  Quiz
//
//  Created by Rushabh Singh on 30/05/21.
//

import Foundation

struct QuizResource {
    
    func getQuestions(completion : @escaping (_ employees : [QuizViewModel]) -> Void) {
        
        var questionsList = [QuizViewModel]()
        let urlString = ApiConstants.QuestionsListUrl
        
        HttpUtil.shared.getData(urlString: urlString, responseType: [QuestionModel].self) { (response) in
            if let response = response {
                questionsList = response.map({
                    return QuizViewModel(question : $0)
                })
            }
            completion(questionsList)
        }
    }
    
}
