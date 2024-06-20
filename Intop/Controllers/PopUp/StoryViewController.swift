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
    
    var story = [GroupedStory]()
    var selectStory = 0
    var selectPhoneNumber = 0
    var user: JSONUser?
    var progressArray = [UIProgressView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(story[1])
        getUserByPhoneNumber()
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
        progressArray[selectStory].animate(Float(story[selectPhoneNumber].story[selectStory].seconds), finish: {
            if self.story[self.selectPhoneNumber].story.count - 1 > self.selectStory {
                self.selectStory += 1
                self.nextStory()
            }else {
                self.selectPhoneNumber += 1
                self.selectStory = 0
                self.nextStory()
            }
        })
        updateStories()
    }
    
    func updateStories() {
        nameAuthor.text = user?.name
        imageAuthor.sd_setImage(with: URL(string: user!.avatar))
        storyImg.sd_setImage(with: URL(string: story[selectPhoneNumber].story[selectStory].mainImage))
    }
    
    func createProgressView() -> UIProgressView{
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0
        progressView.progressTintColor = UIColor(named: "OrangeMain")
        return progressView
    }
    
    
    func getUserByPhoneNumber() {
        Task{
            let user = try await User().getInfoUser(story[selectPhoneNumber].phoneNumber)
            self.user = user
            design()
        }
    }
    
    
    @IBAction func nextStoryBtn(_ sender: UIButton) {
        progressArray[selectStory].setProgress(1, animated: false)
    }
    
    @IBAction func backStoryBtn(_ sender: UIButton) {
    }
}
