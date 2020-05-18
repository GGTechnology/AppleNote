//
//  SnakeGameVC.swift
//  snake
//
//  Created by kadis on 2020/5/18.
//  Copyright © 2020 Lv. All rights reserved.
//

import UIKit

private enum safariEnum {
    case up
    case left
    case down
    case right
}

private let GameViewCellIdentifier:NSString = "GameViewCellIdentifier"
private var GameView:UICollectionView!

class SnakeGameVC: SnakeBaseVC {
    
    private var safari:safariEnum = .up
    
    lazy var GameView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 25, height: 25)
        
        
        let GameView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        GameView.delegate = self
        GameView.dataSource = self
        GameView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: GameViewCellIdentifier as String)
        GameView.backgroundColor = .gray
        
        
        return GameView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        
        print(safari)
        self.view.addSubview(GameView)
    }
}

extension SnakeGameVC:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 225
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameViewCellIdentifier as String, for: indexPath)
        
        
        if (indexPath.item % 2 == 0) {
            cell.backgroundColor = .yellow
        } else {
            cell.backgroundColor = .orange
        }
        
        return cell
    }
    
}
