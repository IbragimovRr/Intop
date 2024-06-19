//
//  StoryViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 13.06.2024.
//

import UIKit

class StoryViewController: UIViewController {

    @IBOutlet weak var nameAuthor: UILabel!
    @IBOutlet weak var imageAuthor: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var storyImg: UIImageView!
    
    var phoneNumber: String?
    var story = [Story]()
    var selectStory = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStoriesByPhoneNumber()
        progressView.setProgress(5, animated: true)
    }

    func getStoriesByPhoneNumber() {
        Task{
            let story = try await Stories().getStoriesByPhoneNumber(phoneNumber: phoneNumber!)
            self.story = story
        }
    }
    
    
}
