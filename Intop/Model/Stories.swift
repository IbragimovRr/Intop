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
    
    func getStories() async throws -> [Story] {
        let url = Constants.url + "stories"
        let value = try await AF.request(url, method: .get).serializingData().value
        let json = JSON(value)
        guard json.count != 0 else { return [Story]() }
        var stories = [Story]()
        for x in 0...json.count - 1 {
            let content = json[x]["content"].stringValue
            let idStory = json[x]["id"].intValue
            let viewed = json[x]["is_viewed"].boolValue
            let mainImage = json[x]["main_image_url"].stringValue
            stories.append(Story(content: content, id: idStory, isViwed: viewed, mainImage: mainImage))
        }
        return stories
    }
}
