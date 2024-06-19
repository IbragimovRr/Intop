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
    
    func getStories()  async throws -> [Story] {
        let url = Constants.url + "stories?viewer_phone_number=%2B\(User.phoneNumber)"
        let value = try await AF.request(url, method: .get).serializingData().value
        let json = JSON(value)
        guard json.count != 0 else {return [Story]() }
        var stories = [Story]()
        for x in 0...json.count - 1 {
            let seconds = json[x]["show_time_in_seconds"].intValue
            let content = json[x]["content"].stringValue
            let idStory = json[x]["id"].intValue
            let viewed = json[x]["is_viewed"].boolValue
            let mainImage = json[x]["main_image_url"].stringValue
            let phoneNumber = json[x]["user_phone_number"].stringValue
            stories.append(Story(content: content, id: idStory, isViewed: viewed, mainImage: mainImage, seconds: seconds, phoneNumber: phoneNumber))
        }
        return stories
    }
    
    func getStoriesByPhoneNumber(phoneNumber: String)  async throws -> [Story] {
        let url = Constants.url + "stories_by_user_phone_number/\(phoneNumber)"
        print(phoneNumber, 7676)
        let value = try await AF.request(url, method: .get).serializingData().value
        let json = JSON(value)
        guard json.count != 0 else {return [Story]() }
        var stories = [Story]()
        for x in 0...json.count - 1 {
            let phoneNumber = json[x]["user_phone_number"].stringValue
            let seconds = json[x]["show_time_in_seconds"].intValue
            let content = json[x]["content"].stringValue
            let idStory = json[x]["id"].intValue
            let viewed = json[x]["is_viewed"].boolValue
            let mainImage = json[x]["main_image_url"].stringValue
            stories.append(Story(content: content, id: idStory, isViewed: viewed, mainImage: mainImage, seconds: seconds, phoneNumber: phoneNumber))
        }
        return stories
    }
}
