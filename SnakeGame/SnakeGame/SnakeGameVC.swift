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
    
    private var safari:safariEnum = .right
    private var snake:[Int] = [102,101,100]
    
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
            self.GameView.reloadData()
           }
       })
       // 启动时间源
       timer.resume()
    }
    
    func configControl() {
        let upBtn = UIButton.init(frame: CGRect(x: 150, y: 400, width: 150, height: 150));
        upBtn.setTitle("⬆️", for: .normal)
        upBtn.tag = 0
        upBtn.addTarget(self, action: #selector(step(_:)), for: .touchUpInside)
        
        let leftBtn = UIButton.init(frame: CGRect(x: 0, y: 550, width: 150, height: 150));
        leftBtn.setTitle("⬅️", for: .normal)
        leftBtn.tag = 1
        leftBtn.addTarget(self, action: #selector(step(_:)), for: .touchUpInside)
        
        let downBtn = UIButton.init(frame: CGRect(x: 150, y: 700, width: 150, height: 150));
        downBtn.setTitle("⬇️", for: .normal)
        downBtn.tag = 2
        downBtn.addTarget(self, action: #selector(step(_:)), for: .touchUpInside)
        
        let rightBtn = UIButton.init(frame: CGRect(x: 200, y: 550, width: 150, height: 150));
        rightBtn.setTitle("➡️", for: .normal)
        rightBtn.tag = 3
        rightBtn.addTarget(self, action: #selector(step(_:)), for: .touchUpInside)
        
        upBtn.backgroundColor = .brown
        leftBtn.backgroundColor = .brown
        downBtn.backgroundColor = .brown
        rightBtn.backgroundColor = .brown
        self.view.addSubview(upBtn)
        self.view.addSubview(leftBtn)
        self.view.addSubview(downBtn)
        self.view.addSubview(rightBtn)
    }
    
    @objc func step(_ btn:UIButton) {
        var tempArray = [Int]()
        var temp:Int = 0
        
        switch btn.tag {
        case 0:// Up Even
            
 
        case 1:// Left Even
            
            safari = .left
            
//            for i in 0..<snake.count {
//                let temp = snake[i] - 1
//                tempArray.append(temp)
//            }
        case 2:// Down Even
            safari = .down
            
//            for i in 0..<snake.count {
//                let temp = snake[i] + 15
//                tempArray.append(temp)
//            }
        default:// Right Even
            
            
            switch safari {
            case .up:
                for i in 0..<snake.count {
                    if i == 0 {
                        temp = snake[i] - 15
                        tempArray.append(temp)
                    } else {
                        temp = snake[i] + 1
                        tempArray.append(temp)
                    }
                }
            case .down:
                for i in 0..<snake.count {
                    if i == 0 {
                        temp = snake[i] + 15
                        tempArray.append(temp)
                    } else {
                        temp = snake[i] + 1
                        tempArray.append(temp)
                    }
                }
            default:
                safari = .right
                return
            }
        }
        
        snake = tempArray
        self.GameView.reloadData()
    }
    
    
    
    func nextStep(tag: Int) {
        
        
        
        if safari == .right {
            for i in 0..<snake.count {
                
                if i == 0 {
                    temp  = snake[i] - 15
                    tempArray.append(temp)
                }
                else {
                    temp  = snake[i] + 1
                    tempArray.append(temp)
                }
            }
        }
        else if safari == .left {
            for i in 0..<snake.count {
                if i == 0 {
                    temp  = snake[i] - 15
                    tempArray.append(temp)
                }
                else {
                    temp  = snake[i] - 1
                    tempArray.append(temp)
                }
            }
        }
        else {
            return
        }
                
        safari = .up
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
        

        cell.backgroundColor = .green
        cell.alpha = 0.5
        
        
//        if (indexPath.item % 2 == 0) {
//            cell.backgroundColor = .black
//        } else {
//            cell.backgroundColor = .white
//        }
        
        for i in 0..<snake.count {
            if (indexPath.item == snake[i]) {
                switch i {
                case 0:
                    cell.backgroundColor = .systemRed
                case 1:
                   cell.backgroundColor = .systemBlue
                default:
                    cell.backgroundColor = .systemYellow
                }
            }
        }
        
        return cell
    }
}
