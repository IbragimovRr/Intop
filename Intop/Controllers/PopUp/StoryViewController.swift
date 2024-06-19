//
//  StoryViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 13.06.2024.
//

import UIKit

class StoryViewController: UIViewController {

    @IBOutlet weak var stackProgress: UIStackView!
    @IBOutlet weak var nameAuthor: UILabel!
    @IBOutlet weak var imageAuthor: UIImageView!
    @IBOutlet weak var storyImg: UIImageView!
    
    var phoneNumber: String?
    var story = [Story]()
    var selectStory = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStoriesByPhoneNumber()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        design()
    }
    
    func design() {
        for _ in 0...1 {
            stackProgress.addArrangedSubview(createProgressView())
        }
        view.layoutSubviews()
    }
    
    func createProgressView() -> UIProgressView{
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0.5
        return progressView
    }
    
    func getStoriesByPhoneNumber() {
        Task{
            //let story = try await Stories().getStoriesByPhoneNumber(phoneNumber: phoneNumber!)
            self.story = story
        }
    }
    
    
}
