//
//  StoryViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 13.06.2024.
//

import UIKit
import SDWebImage

class StoryViewController: UIViewController {

    @IBOutlet weak var stackProgress: UIStackView!
    @IBOutlet weak var nameAuthor: UILabel!
    @IBOutlet weak var imageAuthor: UIImageView!
    @IBOutlet weak var storyImg: UIImageView!
    
    var phoneNumber: String?
    var story = [Story]()
    var selectStory = 0
    var user: JSONUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getStoriesByPhoneNumber()
        getUserByPhoneNumber()
        
    }

    func design() {
        if story.count > 0 {
            for _ in 0...story.count - 1 {
                stackProgress.addArrangedSubview(createProgressView())
            }
            nameAuthor.text = user?.name
//            imageAuthor.sd_setImage(with: URL(string: user!.avatar))
            storyImg.sd_setImage(with: URL(string: story[selectStory].mainImage))
            print(user)
        }
        
    }
    
    func createProgressView() -> UIProgressView{
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0.5
        return progressView
    }
    
    func getStoriesByPhoneNumber() {
        Task{
            let story = try await Stories().getStoriesByPhoneNumber(phoneNumber: phoneNumber!)
            self.story = story
            design()
        }
    }
    func getUserByPhoneNumber() {
        Task{
            let user = try await User().getInfoUser(phoneNumber!)
            self.user = user
        }
    }
    
}
