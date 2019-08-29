//
//  APNoteCell.swift
//  AppleNote
//
//  Created by kadis on 2019/8/29.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

class APNoteCell: UITableViewCell {

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
        self.backgroundColor = .brown
        self.textLabel?.text = "string"
        
    }
    
    func setFoundation(string:String) {
        self.textLabel?.text = String(string)
    }
}
