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
    private var Index:Int = 100
    
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
        
        //  self.startTimer()
        
        self.configControl()
    }
    
    func startTimer() {
       // 定义需要计时的时间
        var timeCount = 225
       // 在global线程里创建一个时间源
       let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
       // 设定这个时间源是每秒循环一次，立即开始
//       timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.schedule(deadline: .now(), repeating: 0.1)
       // 设定时间源的触发事件
       timer.setEventHandler(handler: {
           // 每秒计时一次
           timeCount = timeCount - 1
           // 时间到了取消时间源
           if timeCount <= 0 {
               timer.cancel()
           }
           // 返回主线程处理一些事件，更新UI等等
           DispatchQueue.main.async {
               print("-------%d",timeCount);
            self.Index += 1
            self.GameView.reloadData()
           }
       })
       // 启动时间源
       timer.resume()
    }
    
    func configControl() {
        let oneB = UIButton.init(frame: CGRect(x: 150, y: 400, width: 150, height: 150));
        let twoB = UIButton.init(frame: CGRect(x: 0, y: 550, width: 150, height: 150));
        let threeB = UIButton.init(frame: CGRect(x: 200, y: 550, width: 150, height: 150));
        let fourB = UIButton.init(frame: CGRect(x: 150, y: 700, width: 150, height: 150));
        oneB.addTarget(self, action: #selector(step(_:)), for: .touchUpInside)
        twoB.addTarget(self, action: #selector(step(_:)), for: .touchUpInside)
        threeB.addTarget(self, action: #selector(step(_:)), for: .touchUpInside)
        fourB.addTarget(self, action: #selector(step(_:)), for: .touchUpInside)
        oneB.tag = 0
        twoB.tag = 1
        threeB.tag = 2
        fourB.tag = 3
        oneB.backgroundColor = .brown
        twoB.backgroundColor = .brown
        threeB.backgroundColor = .brown
        fourB.backgroundColor = .brown
        self.view.addSubview(oneB)
        self.view.addSubview(twoB)
        self.view.addSubview(threeB)
        self.view.addSubview(fourB)
    }
    
    @objc func step(_ btn:UIButton) {
        switch btn.tag {
        case 0:
            Index -= 15
        case 1:
            Index -= 1
        case 2:
            Index += 1
        default:
            Index += 15
        }
        
        self.GameView.reloadData()
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
        
//
//        if (indexPath.item % 2 == 0) {
//            cell.backgroundColor = .black
//        } else {
            cell.backgroundColor = .white
//        }
        
        if (indexPath.item == Index) {
            cell.backgroundColor = .yellow
        }
        
        return cell
    }
}
