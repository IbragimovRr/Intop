//
//  ChatViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 16.05.2024.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
       
        
    }
    

    

}
