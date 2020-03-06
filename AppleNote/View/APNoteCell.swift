//
//  APNoteCell.swift
//  AppleNote
//
//  Created by kadis on 2019/8/29.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class APNoteCell: UITableViewCell {
    
    lazy var dayLabel = UILabel()
    lazy var dateLabel = UILabel()
    lazy var addressLabel = UILabel()
    lazy var timeLabel = UILabel()
    lazy var iconographImageView = UIImageView()
    lazy var contentLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI()  {
        self.contentView.backgroundColor = colorWithHex(hexColor: 0xEFF4F6)
        
        let verticalLine = UIView()
        verticalLine.backgroundColor = colorWithHex(hexColor: 0xD2D0D0)
        self.contentView.addSubview(verticalLine)
        verticalLine.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(0)
            make.left.equalTo(67)
            make.size.equalTo(CGSize(width: 1, height: 116))
        }
        let circleView = UIView()
        circleView.backgroundColor = colorWithHex(hexColor: 0xD2D0D0)
        circleView.layer.cornerRadius = 8.5
        circleView.layer.masksToBounds = true
        self.contentView.addSubview(circleView)
        circleView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(25)
            make.centerX.equalTo(verticalLine.snp.centerX)
            make.size.equalTo(CGSize(width: 17, height: 17))
        }
        let insideCircleView = UIView()
        insideCircleView.backgroundColor = colorWithHex(hexColor: 0xEFF4F6)
        insideCircleView.layer.cornerRadius = 7.5
        insideCircleView.layer.masksToBounds = true
        self.contentView.addSubview(insideCircleView)
        insideCircleView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(26)
            make.centerX.equalTo(verticalLine.snp.centerX)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        self.contentView.addSubview(dayLabel)
        dayLabel.textColor = .black
        dayLabel.font = UIFont.systemFont(ofSize: 14)
        dayLabel.textAlignment = .center
        dayLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(15)
            make.left.equalTo(0)
            make.right.equalTo(circleView.snp.left).offset(0)
        }
        
        self.contentView.addSubview(dateLabel)
        dateLabel.textColor = .black
        dateLabel.font = UIFont.systemFont(ofSize: 10)
        dateLabel.textAlignment = .center
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            make.left.equalTo(0)
            make.right.equalTo(circleView.snp.left).offset(0)
        }
        
        let triangleImageView = UIImageView()
        triangleImageView.image = UIImage.init(named: "icon_left_triangle")
        self.contentView.addSubview(triangleImageView)
        triangleImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(circleView.snp.right).offset(5)
            make.centerY.equalTo(circleView.snp.centerY)
            make.size.equalTo(CGSize(width: 11, height: 22))
        }
        
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = .white
        whiteBackgroundView.layer.masksToBounds = true
        whiteBackgroundView.layer.cornerRadius = 5
        self.contentView.addSubview(whiteBackgroundView)
        whiteBackgroundView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(10)
            make.left.equalTo(triangleImageView.snp.right).offset(0)
            make.right.bottom.equalTo(-15)
        }
        
        timeLabel.textColor = .gray
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        whiteBackgroundView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(10)
            make.bottom.equalTo(-5)
        }
        
        addressLabel.textColor = .gray
        addressLabel.font = UIFont.systemFont(ofSize: 10)
        whiteBackgroundView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(timeLabel.snp.right).offset(15)
            make.bottom.equalTo(-5)
        }
        
        iconographImageView.layer.masksToBounds = true
        iconographImageView.layer.cornerRadius = 3
        whiteBackgroundView.addSubview(iconographImageView)
        iconographImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        whiteBackgroundView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) -> Void in
            make.top.left.equalTo(10)
            make.bottom.equalTo(timeLabel.snp.top).offset(-10)
            make.right.equalTo(iconographImageView.snp.left).offset(-10)
        }
    }
    
    func setDate(model:APModel) {
        let dwStr:String = "\(model.day)" + " " + "\(model.week)"
        if (dwStr.count == 5) {
            let attrStr = NSMutableAttributedString.init(string: dwStr)
            attrStr.addAttribute(NSAttributedString.Key.font, value:UIFont.systemFont(ofSize: 10), range:NSRange.init(location:3, length: 2))
            dayLabel.attributedText = attrStr
        }
        
        dateLabel.text = model.date
        timeLabel.text = model.time
        addressLabel.text = model.address
        contentLabel.text = model.content
        if (model.image.count > 0) {
            let imageURL:String = "\(AP_GetRequestStr(inteface: .image))" + "\(model.image[0])"
            iconographImageView.kf.setImage(with: URL(string: imageURL))
        } else {
            contentLabel.snp.makeConstraints { (make) -> Void in
                make.top.left.equalTo(10)
                make.bottom.equalTo(timeLabel.snp.top).offset(-10)
                make.right.equalTo(-10)
            }
        }
    }
}
