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
    
    var currentProgressIndex = 0
    
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
        if selectPhoneNumber < story.count && selectStory < story[selectPhoneNumber].story.count {
            progressArray[selectStory].animate(Float(story[selectPhoneNumber].story[selectStory].seconds), finish: {
                if self.story[self.selectPhoneNumber].story.count - 1 > self.selectStory {
                    self.selectStory += 1
                    self.nextStory()
                } else {
                    self.selectStory = 0
                    self.selectPhoneNumber += 1
                    
                    if self.selectPhoneNumber < self.story.count {
                        for subview in self.stackProgress.arrangedSubviews {
                            self.stackProgress.removeArrangedSubview(subview)
                            subview.removeFromSuperview()
                        }
                        
                        
                        let progressView = self.createProgressView()
                        self.stackProgress.addArrangedSubview(progressView)
                        self.progressArray.append(progressView)
                        progressView.start(Float(self.story[self.selectPhoneNumber].story[self.selectStory].seconds))
                        print(self.user?.phoneNumber)
                        self.updateStories()
                    }
                }
            })
        }
    }
    
    func updateStories() {
        if selectPhoneNumber < story.count && selectStory < story[selectPhoneNumber].story.count {
            nameAuthor.text = user?.name
            imageAuthor.sd_setImage(with: URL(string: user!.avatar))
            storyImg.sd_setImage(with: URL(string: story[selectPhoneNumber].story[selectStory].mainImage))
        }
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
        progressArray[selectStory].start(Float(story[selectPhoneNumber].story[selectStory].seconds))
    }
    
    @IBAction func backStoryBtn(_ sender: UIButton) {
        if selectStory > 0 {
            progressArray[selectStory].progress = 0
            progressArray[selectStory].stop()
            progressArray[selectStory - 1].progress = 0
            progressArray[selectStory - 1].animate(Float(story[selectPhoneNumber].story[selectStory].seconds)) {
                        self.selectStory += 1
                        self.nextStory()
                }
            
            selectStory -= 1
        } else {
            progressArray[selectStory].progress = 0
        }
        
    }
}
