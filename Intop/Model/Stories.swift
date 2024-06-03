//
//  Stories.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 16.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class Stories {
    
    func getStories(completion:@escaping ([Story]) -> ()) {
        let url = Constants.url + "stories"
        AF.request(url, method: .get).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                guard json.count != 0 else { return }
                var stories = [Story]()
                for x in 0...json.count - 1 {
                    let content = json[x]["content"].stringValue
                    let idStory = json[x]["id"].intValue
                    let viewed = json[x]["is_viewed"].boolValue
                    let avatar = json[x]["avatar"].stringValue
                    let mainImage = json[x]["main_image_url"].stringValue
                    stories.append(Story(avatar: avatar, content: content, id: idStory, isViwed: viewed, mainImage: mainImage))
                }
                completion(stories)
            case .failure(let error):
                print(error)
            }
        }
    }
}
