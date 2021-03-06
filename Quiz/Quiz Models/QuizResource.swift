//
//  QuizResource.swift
//  Quiz
//
//  Created by Rushabh Singh on 30/05/21.
//

import Foundation

struct QuizResource {
    
    func getQuestions(completion : @escaping (_ employees : [QuestionsDataModel]) -> Void) {
        var questionsList = [QuestionsDataModel]()
        let urlString = ApiConstants.QuestionsListUrl
        HttpUtil.shared.getData(urlString: urlString, responseType: [QuestionModel].self) { (response) in
            if let response = response {
                questionsList = response.map({
                    return QuestionsDataModel(question : $0)
                })
            }
            completion(questionsList)
        }
    }
    
}
