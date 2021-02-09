//
//  UserInfoView.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/11.
//  刻圓角＋邊框

import Foundation
import UIKit

class UserInfoView: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addBorder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addBorder()
    }
    
    func addBorder() {
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(red: 255/255, green: 189/255, blue: 193/255, alpha: 1).cgColor
        self.clipsToBounds = true
    }
}
