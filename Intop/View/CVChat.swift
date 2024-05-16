//
//  CVChat.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 16.05.2024.
//

import Foundation
import UIKit

extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "story", for: indexPath) as! ChatCollectionViewCell
        return cell
    }
    
    
}
