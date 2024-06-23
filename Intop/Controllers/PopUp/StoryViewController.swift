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
    var user: JSONUser?
    var selectStory: Int = 0
    var selectPhoneNumber: Int = 0
    var progressArray = [UIProgressView]()
    var progressView = ProgressView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        createProgress()
        getUserByPhoneNumber()
        addStoryInDesign()
    }
    
    func selectProgress() {
        for x in 0...progressArray.count - 1 {
            if x > selectStory {
                progressArray[x].progress = 0
            }else if x < selectStory {
                progressArray[x].progress = 1
            }else if x == selectStory {
                progressArray[x].progress = 0
                progressView.startProgress(progressArray[selectStory], seconds: Float(story[selectPhoneNumber].story[selectStory].seconds))
            }
        }
    }
    
    func createProgress() {
        progressArray.removeAll()
        stackViewRemoveAll()
        for _ in 1...story[selectPhoneNumber].story.count {
            let progressView = progressView.createProgress()
            progressArray.append(progressView)
            stackProgress.addArrangedSubview(progressView)
        }
    }
    
    func stackViewRemoveAll() {
        stackProgress.arrangedSubviews.forEach { view in
            stackProgress.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func nextUser() {
        selectPhoneNumber += 1
        selectStory = 0
        addStoryInDesign()
        getUserByPhoneNumber()
        createProgress()
    }

    func nextStory() {
        selectStory += 1
        addStoryInDesign()
    }
    
    func backUser() {
        selectPhoneNumber -= 1
        selectStory = 0
        addStoryInDesign()
        getUserByPhoneNumber()
        createProgress()
    }
    
    func backStory() {
        selectStory -= 1
        addStoryInDesign()
    }
    
    func addStoryInDesign() {
        let story = story[selectPhoneNumber].story[selectStory]
        storyImg.sd_setImage(with: URL(string: story.mainImage))
        selectProgress()
        
    }
    
    func getUserByPhoneNumber() {
        Task{
            let user = try await User().getInfoUser(story[selectPhoneNumber].phoneNumber)
            self.user = user
            addUserInfo()
        }
    }
    
    func addUserInfo() {
        nameAuthor.text = user!.name
        imageAuthor.sd_setImage(with: URL(string: user!.avatar))
    }
    
    
    @IBAction func nextStoryBtn(_ sender: UIButton) {
        if selectStory == story[selectPhoneNumber].story.count - 1 && story.count - 1 > selectPhoneNumber{
            nextUser()
        }else if selectStory != story[selectPhoneNumber].story.count - 1{
            nextStory()
        }else {
            print("Истории закончились")
        }
    }
    
    @IBAction func backStoryBtn(_ sender: UIButton) {
        if selectStory == 0 && selectPhoneNumber != 0{
            backUser()
        }else if selectStory != 0 {
            backStory()
        }else {
            print("Начало историй")
        }
    }
    
    
}
