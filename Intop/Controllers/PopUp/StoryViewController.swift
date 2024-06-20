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
    var progressArray = [UIProgressView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStoriesByPhoneNumber()
        tabBarController?.tabBar.isHidden = true
    }

    func design() {
        if story.count > 0 {
            for _ in 0...story.count - 1 {
                let progressView = createProgressView()
                stackProgress.addArrangedSubview(progressView)
                progressArray.append(progressView)
            }
            nextStory()
        }
    }
    
    func nextStory() {
        progressArray[selectStory].animate(Float(story[selectStory].seconds), finish: {
            if self.story.count - 1 > self.selectStory {
                self.selectStory += 1
                self.nextStory()
            }
        })
        nameAuthor.text = user?.name
        imageAuthor.sd_setImage(with: URL(string: user!.avatar))
        storyImg.sd_setImage(with: URL(string: story[selectStory].mainImage))
    }
    
    func createProgressView() -> UIProgressView{
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0
        progressView.progressTintColor = UIColor(named: "OrangeMain")
        return progressView
    }
    
    func getStoriesByPhoneNumber() {
        Task{
            try await getUserByPhoneNumber()
            let story = try await Stories().getStoriesByPhoneNumber(phoneNumber: phoneNumber!)
            self.story = story
            design()
        }
    }
    func getUserByPhoneNumber() async throws {
        let user = try await User().getInfoUser(phoneNumber!)
        self.user = user
    }
    
}
